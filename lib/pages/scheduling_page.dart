import 'package:dentalapp/components/my_scheduling_button.dart';
import 'package:dentalapp/components/my_text_field.dart';
import 'package:flutter/material.dart';


import 'home_page.dart';

class CreateMedicalMeeting extends StatefulWidget{

  const CreateMedicalMeeting({super.key});

  @override
  State<CreateMedicalMeeting> createState() => _CreateMedicalMeetingState();

}

class _CreateMedicalMeetingState extends State<CreateMedicalMeeting>{

  final emailController = TextEditingController();
  final phoneController = TextEditingController();

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
                        // Calendar

                        // Name field
                        MyTextField(
                          controller: emailController,
                          hintText: 'Full name',
                          obscureText: false,
                        ),
                        const SizedBox(height: 15),

                        // Phone number field
                        MyTextField(
                          controller: phoneController,
                          hintText: 'Your phone number',
                          obscureText: false,
                        ),
                        const SizedBox(height: 50),

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