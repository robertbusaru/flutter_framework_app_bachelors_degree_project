import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCalendarButton extends StatelessWidget{
  final Function()? onTap;

  const MyCalendarButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.8),
            border: Border.all(color: Colors.black.withOpacity(0.8)),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(1, 6), // changes position of shadow
              ),
            ],
          ),
          child: Center(
            child: Text('Next step',
              style: GoogleFonts.aBeeZee(
                fontSize: 18,
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