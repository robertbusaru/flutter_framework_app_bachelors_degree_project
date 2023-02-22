import 'package:dentalapp/components/my_button.dart';
import 'package:dentalapp/components/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget{
  LoginPage({super.key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  // sign user to account method
  void signInUser() {

  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/images/vector_login.png',
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 10),
                // Welcome \n Login to your account
                Text('Welcome',
                    style: GoogleFonts.aBeeZee(
                      fontSize: 32,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )
                ),
                const SizedBox(height: 10),
                Text(
                    'Login to your account',
                    style: GoogleFonts.aBeeZee(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )
                ),
                const SizedBox(height: 30),

                // Email field
                MyTextField(
                  controller: usernameController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 20),

                // Password field
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 5),
                // Forgot password?
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Text(
                        "Forgot password? ",
                        style: GoogleFonts.aBeeZee(
                          fontSize: 15,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          )
                        ),
                      ),
                    ]
                ),
                const SizedBox(height: 40),

                // sign in field
                MyButton(
                  onTap: signInUser,
                ),
                const SizedBox(height: 10),

                // Register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                        style: GoogleFonts.aBeeZee(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )
                    ),
                      Text(
                        'Create now',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 18,
                            color: Colors.lightBlueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                      ),
                  ],
                ),
                const SizedBox(height: 30),
                // Or connect with one of those:
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      const Expanded(
                        child:
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text('Or continue with',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const Expanded(
                        child:
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // google and facebook login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/images/facebook.png',
                      height: 40,
                      width: 40,
                    ),
                    const SizedBox(width: 100),
                    Image.asset(
                      'lib/images/google.png',
                      height: 40,
                      width: 40,
                    ),
                  ]
                ),
              ]),
          )
        )
      )
    );
  }
}