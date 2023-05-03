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