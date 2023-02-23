import 'package:dentalapp/components/my_button.dart';
import 'package:dentalapp/components/my_create_now_button.dart';
import 'package:dentalapp/components/my_text_field.dart';
import 'package:dentalapp/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user to account method
  void signInUser() async {

    // show loading circle
    showDialog(
      context: context,
      builder: (context){
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            backgroundColor: Colors.white,
          ),
        );
      },
    );

    // try sign in method
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found'){
        wrongEmailMessage();
      } else if (e.code == 'wrong-password'){
        wrongPasswordMessage();
      }
    }
    // pop the circle, loading screen
    deleteCircle();
  }
  // wrong email message function
  void wrongEmailMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Email not found!'),
          );
        },
    );
  }

  void deleteCircle(){
    // pop the ciruclar loading screen
    Navigator.pop(context);
  }

  // wrong password message function
  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Incorrect password, try again!'),
        );
      },
    );
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
                  controller: emailController,
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
                    MyCreateNowButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterPage()),
                        );
                      },
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