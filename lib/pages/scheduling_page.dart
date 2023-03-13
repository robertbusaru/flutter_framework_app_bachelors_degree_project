import 'package:dentalapp/components/my_scheduling_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'home_page.dart';

class CreateMedicalMeeting extends StatefulWidget{

  const CreateMedicalMeeting({super.key});

  @override
  State<CreateMedicalMeeting> createState() => _CreateMedicalMeetingState();

}

class _CreateMedicalMeetingState extends State<CreateMedicalMeeting>{

  DateTime today = DateTime.now();

  void _onDaySelected(DateTime day, DateTime focusedDay){
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Plan your schedule',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Calendar
                        content(),
                        const SizedBox(height: 30),

                        // Selected date field
                        Text(
                          "Selected day: ${today.toString().split(" ")[0]}",
                          style: GoogleFonts.aBeeZee(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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

  Widget content() {
    return Column(
      children: [
        TableCalendar(
          locale: "en_US",
          rowHeight: 40,
          headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
          ),
          availableGestures: AvailableGestures.all,
          focusedDay: today,
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
              border: Border.all(
                  color: Colors.grey,
                  width: 2.0
              ),
            ),
            weekendTextStyle: const TextStyle(color: Colors.red),
          ),
          selectedDayPredicate: (day) => isSameDay(day, today),
          firstDay: DateTime.now().subtract(const Duration(days: 365)),
          lastDay: DateTime.now().add(const Duration(days: 365)),
          onDaySelected: _onDaySelected,
        )
      ],
    );
  }

}