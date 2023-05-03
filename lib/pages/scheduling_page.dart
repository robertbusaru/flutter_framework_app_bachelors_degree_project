import 'package:flutter/material.dart';
import '../services/calendar.dart';


class CreateMedicalMeeting extends StatefulWidget{

  const CreateMedicalMeeting({super.key});

  @override
  State<CreateMedicalMeeting> createState() => _CreateMedicalMeetingState();

}

class _CreateMedicalMeetingState extends State<CreateMedicalMeeting>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.8),
        elevation: 20,
        title: const Text('Calendar'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 600,
              child: FlutterDatePickerExample(),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

}

