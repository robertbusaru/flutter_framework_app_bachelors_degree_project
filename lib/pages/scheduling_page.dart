import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SchedulingPage extends StatefulWidget {
  const SchedulingPage({Key? key}) : super(key: key);

  @override
  _SchedulingPageState createState() => _SchedulingPageState();
}

class _SchedulingPageState extends State<SchedulingPage> {

  List<Booking> bookings = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.9),
        elevation: 25,
        title: const Text('Available appointments'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (BuildContext context, int index) {
          Booking booking = bookings[index];
          return BookingCard(
            booking: booking,
          );
        },
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
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 10,
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
            Text(
              'Date & Time: $formattedDate',
              style: GoogleFonts.aBeeZee(
                fontSize: 13.3,
                color: Colors.black,
              ),),
            Text(booking.description),
          ],
        ),
        trailing: InkWell(
          onTap: () {
            // Logica pentru selectarea programării
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(1, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
    );
  }
}
