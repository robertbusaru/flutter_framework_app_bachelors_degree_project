import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCreateNowButton extends StatelessWidget{
  final Function()? onTap;

  const MyCreateNowButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Text(
          'Create now',
          style: GoogleFonts.aBeeZee(
            fontSize: 15,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}