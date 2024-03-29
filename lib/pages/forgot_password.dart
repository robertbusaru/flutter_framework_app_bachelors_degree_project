import 'package:dentalapp/components/my_text_field.dart';
import 'package:dentalapp/pages/auth_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/my_go_back_button.dart';
import '../components/my_reset_password_button.dart';

class ForgotPassword extends StatefulWidget{

  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();

}

class _ForgotPasswordState extends State<ForgotPassword>{

  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailController.text.trim());
      dialogFunction();

    } on FirebaseAuthException catch (_) {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
                content: Text('Try again'),
            );
          }
      );
    }
  }

  void dialogFunction() {
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
                Icons.email,
                size: 50,
                color: Colors.black,
              ),
              const SizedBox(height: 10),

              Text(
                'Password reset link successfully sent!\n\nPlease check your email address!',
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


  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading:
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AuthPage()),
                );
              },
              icon: const Icon(Icons.arrow_back),
              color: Colors.black,
            )
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Center(
                child: SingleChildScrollView(
                  child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'lib/images/vector_login.png',
                          height: 120,
                          width: 120,
                        ),
                        const SizedBox(height: 30),

                        // Create a new account text
                        Text(
                            'Forgot your password?',
                            style: GoogleFonts.aBeeZee(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                        const SizedBox(height: 20),
                        Text(
                            "Enter your registered email below, to receive password reset instructions",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.aBeeZee(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                        const SizedBox(height: 50),

                        // Email field
                        MyTextField(
                          controller: emailController,
                          hintText: 'Email',
                          obscureText: false,
                        ),
                        const SizedBox(height: 150),

                        MyResetPasswordButton(
                          onTap: passwordReset,
                        ),
                        const SizedBox(height: 10),

                        // Remember password?
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                "Remember your password?",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.aBeeZee(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )
                            ),
                            MyGoBackButton(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const AuthPage()),
                                );
                              },
                            ),
                          ],
                        ),
                          const SizedBox(height: 30),
                          Text(
                            "© 2023 Robert Busaru",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.aBeeZee(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            //


                          ),
                      ]
                  ),
                )
            )
        )
    );
  }
}