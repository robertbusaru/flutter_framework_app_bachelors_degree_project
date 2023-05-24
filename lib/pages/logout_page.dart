import 'package:dentalapp/components/my_logout_button.dart';
import 'package:dentalapp/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'auth_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LogoutPage extends StatefulWidget {
  const LogoutPage({super.key});

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  String name = '';
  String email = '';
  String phoneNumber = '';

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    // Obține utilizatorul curent
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Obține referința către documentul utilizatorului din Firestore
      DocumentSnapshot snapshot =
      await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

      // Extrage datele utilizatorului din document
      Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;

      // Actualizează starea cu datele utilizatorului
      setState(() {
        name = userData['full name'];
        email = userData['email'];
        phoneNumber = userData['phone number'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.account_circle_rounded,
                  color: Colors.black,
                  size: 150,
                  semanticLabel: 'Text to announce in accessibility modes',
                ),
                const SizedBox(height: 30),

                // Logged in user text
                Text.rich(
                  TextSpan(
                    text: 'Logged as: ',
                    style: GoogleFonts.aBeeZee(
                      fontSize: 18,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: name,
                        style: GoogleFonts.aBeeZee(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Email: $email',
                  style: GoogleFonts.aBeeZee(fontSize: 16),
                ),
                Text(
                  'Phone number: $phoneNumber',
                  style: GoogleFonts.aBeeZee(fontSize: 16),
                ),

                const SizedBox(height: 220),

                MyLogOutButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AuthPage()),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  "© 2023 Robert Busaru",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.aBeeZee(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
