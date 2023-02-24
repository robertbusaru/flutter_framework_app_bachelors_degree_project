import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../pages/auth_page.dart';

class MyLogOutButton extends StatelessWidget{
  final Function()? onTap;

  const MyLogOutButton({
    super.key,
    required this.onTap,
  });

    @override
    Widget build(BuildContext context){

    void signUserOut(){
      FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: ((context) => const AuthPage())
          )
      );
   }

    return GestureDetector(
      onTap: () {
        onTap;
        signUserOut();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(30),),
          child: Center(
            child: Text('Log out',
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