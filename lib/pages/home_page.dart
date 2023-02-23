import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget{
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

// sign out method
void signUserOut(){
  FirebaseAuth.instance.signOut();
}

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: signUserOut,
              icon: const Icon(Icons.logout),
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
                'Time to a big smile!',
                style: GoogleFonts.aBeeZee(
                  fontSize: 32,
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
                    // Adăugați aici codul pentru a crea o programare la medic
                  },
                  icon: const Icon(Icons.schedule, size: 40),
                ),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: () {
                    // Adăugați aici codul pentru a accesa pagina principală
                  },
                  icon: const Icon(Icons.home, size: 40),
                ),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: () {
                    // Adăugați aici codul pentru a accesa chat-ul
                  },
                  icon: const Icon(Icons.chat, size: 40),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      )

  );
}