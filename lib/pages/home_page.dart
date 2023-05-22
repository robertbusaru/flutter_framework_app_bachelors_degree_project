import 'package:dentalapp/pages/chat_page.dart';
import 'package:dentalapp/pages/logout_page.dart';
import 'package:dentalapp/pages/scheduling_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget{
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

// sign out method
// void signUserOut(){
//   FirebaseAuth.instance.signOut();
// }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LogoutPage()),
                );
              },
              icon: const Icon(Icons.more_vert),
              color: Colors.black,
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Image.asset(
                    'lib/images/vector_login.png',
                    height: 250,
                    width: 250,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Time to a big smile!
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                "It's time for a smile!",
                style: GoogleFonts.aBeeZee(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 250),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SchedulingPage()),
                    );
                  },
                  icon: const Icon(Icons.calendar_today, size: 40),
                ),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  icon: const Icon(Icons.home_outlined, size: 45),
                ),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ChatScreen()),
                    );
                  },
                  icon: const Icon(Icons.chat_bubble_outline_rounded, size: 40),
                ),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      )
  );
}