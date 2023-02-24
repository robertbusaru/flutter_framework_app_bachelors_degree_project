import 'package:dentalapp/components/my_text_field.dart';
import 'package:dentalapp/pages/auth_page.dart';
import 'package:dentalapp/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/my_go_back_button.dart';
import '../components/my_register_button.dart';

class RegisterPage extends StatefulWidget{

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();

}

class _RegisterPageState extends State<RegisterPage>{
  // text editing controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

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
                          height: 90,
                          width: 90,
                        ),
                        const SizedBox(height: 30),

                        // Register text
                        Text('Register',
                            style: GoogleFonts.aBeeZee(
                              fontSize: 28,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                        const SizedBox(height: 10),

                        // Create a new account text
                        Text(
                            'Create a new account',
                            style: GoogleFonts.aBeeZee(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                        const SizedBox(height: 30),

                        // Full name field
                        MyTextField(
                          controller: nameController,
                          hintText: 'Full Name',
                          obscureText: false,
                        ),
                        const SizedBox(height: 15),

                        // Email field
                        MyTextField(
                          controller: emailController,
                          hintText: 'Email',
                          obscureText: false,
                        ),
                        const SizedBox(height: 15),

                        // Phone number field
                        MyTextField(
                          controller: phoneController,
                          hintText: 'Your phone number',
                          obscureText: false,
                        ),
                        const SizedBox(height: 15),

                        // Password field
                        MyTextField(
                          controller: passwordController,
                          hintText: 'Password',
                          obscureText: true,
                        ),
                        const SizedBox(height: 50),

                        // sign in field
                        MyRegisterButton(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginPage()),
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