import 'package:cloud_firestore/cloud_firestore.dart';
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
        backgroundColor: Colors.black.withOpacity(0.9),
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
                      color: isSelected ? Colors.black: Colors.transparent,
                      border: Border.all(color: Colors.white.withOpacity(0.8)),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(1, 6),
                        ),
                      ],
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
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                            Text(
                              '${date.day}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: isSelected ? Colors.white : Colors.black,
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

  @override
  Widget build(BuildContext context) {

    String formattedDate = '${booking.date.day.toString().padLeft(2, '0')}.${booking.date.month.toString().padLeft(2, '0')}.${booking.date.year} | ${booking.date.hour.toString().padLeft(2, '0')}:${booking.date.minute.toString().padLeft(2, '0')} ${booking.date.hour < 12 ? 'AM' : 'PM'}';

    return Card(
      child: Container(
        height: 80, // Înălțimea dorită pentru card
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          border: Border.all(color: Colors.white.withOpacity(0.8)),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
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
                ],
              ),
              Text(booking.description),
            ],
          ),
          trailing: InkWell(
            onTap: () {
              // Logica pentru selectarea programării
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                border: Border.all(color: Colors.black.withOpacity(0.8)),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.9),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(1, 4), // changes position of shadow
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 13),
              child: const Text(
                'Select',
                style: TextStyle(
                  color: Colors.white,
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
