import 'package:dentalapp/components/my_scheduling_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:riverpod/riverpod.dart';
import 'home_page.dart';


class CreateMedicalMeeting extends StatefulWidget{

  const CreateMedicalMeeting({super.key});

  @override
  State<CreateMedicalMeeting> createState() => _CreateMedicalMeetingState();

}

class _CreateMedicalMeetingState extends State<CreateMedicalMeeting>{

  DateTime today = DateTime.now();
  final selectedDate = StateProvider((ref) => DateTime.now());

  void _setSelectedDate(DateTime date) {
    context.read().state = date;
    String formattedDate = DateFormat.yMMMMd().format(date);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Data selectată: $formattedDate'),
      ),
    );
  }


  displayTimeSlot(BuildContext context) {
    final now = today;
    return Column(
      children: [
        Container(
          color: Colors.teal.withOpacity(0.3),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Center(
                    child: Padding(padding: const EdgeInsets.all(12),
                      child: Column(children: [
                        Text(DateFormat.EEEE().format(now),
                          style: GoogleFonts.aBeeZee(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            ),
                        ),
                        Text('${now.day}',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(DateFormat.MMMM().format(now),
                          style: GoogleFonts.aBeeZee(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                      ),
                    ),
                  ),
              ),
              GestureDetector(
                  onTap: (){
                    DatePicker.showDatePicker(
                        context,
                        showTitleActions: true,
                        minTime: now,
                        maxTime: now.add(const Duration(days: 31)),
                        onConfirm: _setSelectedDate,
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.calendar_today),
                    ),
                  ),
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text(
              'Plan your schedule',
              style: GoogleFonts.aBeeZee(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            leading:
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              icon: const Icon(Icons.arrow_back),
              color: Colors.black,
            )
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Center(
                child: SingleChildScrollView(
                  child:Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Calendar
                        displayTimeSlot(context),

                        const SizedBox(height: 30),

                        // Selected date field
                        // Text(
                        //   "Selected day: ${today.toString().split(" ")[0]}",
                        //   style: GoogleFonts.aBeeZee(
                        //     fontSize: 15,
                        //     color: Colors.black,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        const SizedBox(height: 150),

                        // Save button
                        MySchedulingButton(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const CreateMedicalMeeting()),
                            );
                          },
                        ),
                      ]
                  ),
                )
            )
        )
    );
  }

}