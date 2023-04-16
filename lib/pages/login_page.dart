import 'package:dentalapp/components/fb_google_auth_buttons.dart';
import 'package:dentalapp/components/my_button.dart';
import 'package:dentalapp/components/my_create_now_button.dart';
import 'package:dentalapp/components/my_forgot_password_button.dart';
import 'package:dentalapp/components/my_text_field.dart';
import 'package:dentalapp/pages/forgot_password.dart';
import 'package:dentalapp/pages/register_page.dart';
import 'package:dentalapp/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';



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
    Future<void> checkEmailExistence() async {

      String email = emailController.text.trim();
      String password = passwordController.text;
      List<String> signInMethods = [];

      try {
        signInMethods = (await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password,
            )
        ) as List<String>;
      } on FirebaseAuthException catch (_) {
        // Handle error
        wrongEmailMessage();
        return;
      }
      if (signInMethods.isNotEmpty) {
      } else {
        wrongEmailMessage();
      }
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (_) {
      checkEmailExistence();
    }

    deleteCircle();   // pop the circle, loading screen
  }

  // wrong email message function
  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.email_outlined,
                size: 50,
                color: Colors.black,
              ),
              const SizedBox(height: 10),

              Text(
                'Authentication failed\n\nPlease double-check your email and password and try again',
                style: GoogleFonts.aBeeZee(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  void deleteCircle(){
    // pop the ciruclar loading screen
    Navigator.pop(context);
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
                const SizedBox(height: 10),

                // Forgot password?
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: MyForgotPasswordButton(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ForgotPassword()),
                            );
                          },
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
                const SizedBox(height: 50),

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
                const SizedBox(height: 25),

                // google and facebook login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageOnButtons(
                        onTap: () => AuthService().signInWithFacebook(),
                        imagePath: 'lib/images/facebook.png'),

                    const SizedBox(width: 100),

                    ImageOnButtons(
                        onTap: () => AuthService().signInWithGoogle(),
                        imagePath: 'lib/images/google.png')
                  ]
                ),
              ]),
          )
        )
      )
    );
  }
}