import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SchedulingPage extends StatefulWidget {
  const SchedulingPage({Key? key}) : super(key: key);

  @override
  _SchedulingPageState createState() => _SchedulingPageState();
}

class _SchedulingPageState extends State<SchedulingPage> {

  List<Booking> bookings = [];
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    fetchBookingsFromFirestore();
  }

  Future<void> fetchBookingsFromFirestore() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('bookings')
          .get();

      List<QueryDocumentSnapshot> documents = querySnapshot.docs;

      for (var doc in documents) {
        String name = doc['name'];
        Timestamp timestamp = doc['timeStamp'];
        String description = doc['description'];

        DateTime date = timestamp.toDate();

        Booking booking = Booking(
          name: name,
          date: date,
          description: description,
        );

        setState(() {
          bookings.add(booking);
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching bookings: $e');
      }
    }
  }

  List<Booking> getBookingsForSelectedDate() {
    // Filtrăm programările în funcție de data selectată
    return bookings.where((booking) {
      return booking.date.year == selectedDate.year &&
          booking.date.month == selectedDate.month &&
          booking.date.day == selectedDate.day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {

    List<Booking> selectedDateBookings = getBookingsForSelectedDate();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 25,
        title: const Text('Available appointments'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100, // Înălțimea dorită pentru lista de zile din calendar
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              scrollDirection: Axis.horizontal,
              itemCount: 7, // Numărul de zile din calendar
              itemBuilder: (BuildContext context, int index) {
                DateTime date = DateTime.now().add(Duration(days: index));
                bool isSelected = date.year == selectedDate.year &&
                    date.month == selectedDate.month &&
                    date.day == selectedDate.day;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDate = date; // Actualizăm data selectată
                    });
                  },
                  child: Container(
                    width: 80,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.greenAccent: Colors.transparent,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                      child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat.MMM().format(date),
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.black : Colors.black,
                              ),
                            ),
                            Text(
                              '${date.day}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.black : Colors.black,
                              ),
                            ),
                          ],
                        ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: ListView.builder(
              itemCount: selectedDateBookings.length,
              itemBuilder: (BuildContext context, int index) {
                Booking booking = selectedDateBookings[index];
                return BookingCard(
                  booking: booking,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Booking {
  final String name;
  final DateTime date;
  final String description;

  Booking({
    required this.name,
    required this.date,
    required this.description,
  });
}

class BookingCard extends StatelessWidget {
  final Booking booking;

  const BookingCard({Key? key, required this.booking}) : super(key: key);

  Future<bool> isBookingInHistory(String bookingName) {
    return FirebaseFirestore.instance
        .collection('history')
        .where('bookingName', isEqualTo: bookingName)
        .get()
        .then((QuerySnapshot querySnapshot) {
      return querySnapshot.docs.isNotEmpty;
    });
  }

  void checkBookingAndShowModal(BuildContext context) async {
    bool existsInHistory = await isBookingInHistory(booking.name);

    if (existsInHistory) {
      showReservationFailedModal(context); // Apelăm funcția de afișare a modalului de rezervare eșuată
    } else {
      _showCongratulationsModal(context); // Apelăm funcția de afișare a modalului de felicitare
    }
  }

  void _showConfirmationDialog(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Are you sure about your selection?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.black,
                      ),
                      child: const Text('Cancel'),
                    ),

                    ElevatedButton(
                      onPressed: () async {
                        String bookingName = booking.name;
                        String phoneNumber = currentUser.phoneNumber ?? '';
                        String userName = currentUser.displayName ?? '';

                        // Salvează în colecția "history" în Firebase
                        await FirebaseFirestore.instance.collection('history').doc(bookingName).set({
                          'bookingName': bookingName,
                          'phoneNumber': phoneNumber,
                          'userName': userName,
                        });
                        // Actualizează starea aplicației / efectuează alte acțiuni necesare
                        checkBookingAndShowModal(context);
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black, backgroundColor: Colors.greenAccent,
                      ),
                      child: const Text('Confirm'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    }
  }

  void showReservationFailedModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.error_outline,
                size: 100,
                color: Colors.red,
              ),
              SizedBox(height: 15),

              Text(
                'Reservation Failed',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'The event has been already confirmed',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        );
      },
    );
  }

  void _showCongratulationsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(
                Icons.check_circle,
                color: Colors.greenAccent,
                size: 100,
              ),
              SizedBox(height: 12),

              Align(
                alignment: Alignment.center,
                child: Text(
                  'Congratulations!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 5),

              Align(
                alignment: Alignment.center,
                child: Text(
                  'Your booking has been successfully confirmed',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget checkBookingAndShowAvailability(BuildContext context) {
    return FutureBuilder<bool>(
      future: isBookingInHistory(booking.name),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Se afișează un indicator de încărcare în timp ce se verifică disponibilitatea
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Se afișează un mesaj de eroare în cazul în care apare o eroare
          return Text(
            'Error: ${snapshot.error}',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          );
        } else {
          bool existsInHistory = snapshot.data ?? false;

          if (existsInHistory) {
            return const Text(
              'Unavailable',
              style: TextStyle(
                fontSize: 14,
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            );
          } else {
            return const Text(
              'Available',
              style: TextStyle(
                fontSize: 14,
                color: Colors.greenAccent,
                fontWeight: FontWeight.bold,
              ),
            );
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    String formattedDate = '${booking.date.day.toString().padLeft(2, '0')}.${booking.date.month.toString().padLeft(2, '0')}.${booking.date.year} | ${booking.date.hour.toString().padLeft(2, '0')}:${booking.date.minute.toString().padLeft(2, '0')} ${booking.date.hour < 12 ? 'AM' : 'PM'}';

    return Card(
      child: Container(
        height: 80, // Înălțimea dorită pentru card
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(1, 6), // changes position of shadow
            ),
          ],
        ),
        child: ListTile(
          title: Text(
            booking.name,
            style: GoogleFonts.aBeeZee(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.access_time_outlined,
                    size: 15,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 4),

                  Text(
                    'Date & Time: $formattedDate',
                    style: GoogleFonts.aBeeZee(
                      fontSize: 13.3,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 4),
                ],
              ),

              Text(booking.description),
              const SizedBox(width: 5),
              checkBookingAndShowAvailability(context),
            ],
          ),
          trailing: InkWell(
            onTap: () {
              _showConfirmationDialog(context);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(1, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              child: const Text(
                'Select',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
