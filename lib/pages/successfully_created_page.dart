import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/my_home_page_button.dart';
import 'home_page.dart';


class AccountCreated extends StatelessWidget{
  const AccountCreated({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: Center(
          child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Image.asset(
                  'lib/images/vector_login.png',
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 20),

                Text('Congratulations',
                    style: GoogleFonts.aBeeZee(
                      fontSize: 28,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )
                ),
                const SizedBox(height: 10),

                // Create a new account text
                Text(
                    'Your account has been successfully created',
                    style: GoogleFonts.aBeeZee(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )
                ),
                const SizedBox(height: 45),

                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Discover our new application ready to welcome you whenever you need help. What do we offer you?'
                        '\n\n * Simple to use and versatile\n * Security\n * Modern and fast environment\n * Data privacy',
                    style: GoogleFonts.aBeeZee(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 45),

                MyHomePageButton(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    }
                ),
                const SizedBox(height: 20),

              ],
          ),
        )
      )
    )
  );
}