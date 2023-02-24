import 'package:dentalapp/components/my_text_field.dart';
import 'package:dentalapp/pages/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/my_go_back_button.dart';
import '../components/my_register_button.dart';

class ForgotPassword extends StatefulWidget{

  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();

}

class _ForgotPasswordState extends State<ForgotPassword>{

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();

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
                          height: 90,
                          width: 90,
                        ),
                        const SizedBox(height: 30),

                        // Register text
                        Text('Password',
                            style: GoogleFonts.aBeeZee(
                              fontSize: 28,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                        const SizedBox(height: 10),

                        // Create a new account text
                        Text(
                            'Set a new password',
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
                        const SizedBox(height: 15),

                        // Password field
                        MyTextField(
                          controller: passwordController,
                          hintText: 'Password',
                          obscureText: true,
                        ),
                        const SizedBox(height: 15),

                        MyTextField(
                          controller: newPasswordController,
                          hintText: 'New Password',
                          obscureText: true,
                        ),
                        const SizedBox(height: 50),

                        // sign in field
                        MyRegisterButton(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const AuthPage()),
                            );
                          },
                        ),

                        const SizedBox(height: 2),
                        // Already have an account?
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                "Already have an account?",
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