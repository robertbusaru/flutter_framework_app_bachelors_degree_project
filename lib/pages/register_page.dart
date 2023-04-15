import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentalapp/components/my_text_field.dart';
import 'package:dentalapp/pages/auth_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/my_go_back_button.dart';
import '../components/my_register_button.dart';
import 'home_page.dart';

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
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future signUp() async {

    if (passwordConfirmed()) {
      // create user
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // add user details
      addUserDetails(
        nameController.text.trim(),
        emailController.text.trim(),
        phoneController.text.trim(),
      );

      goToHomePage();
    }
  }

  Future addUserDetails(String fullName, String email, String phoneNumber) async {

    await FirebaseFirestore.instance.collection('users').add({
        'full name': fullName,
        'email': email,
        'phone number': phoneNumber,
      }
    );

  }

  void goToHomePage() {
    if (passwordController.text.trim() == confirmPasswordController.text.trim()) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }
  }

  bool passwordConfirmed() {
    if (passwordController.text.trim() == confirmPasswordController.text.trim()){
      return true;
    } else {
      return false;
    }

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
                        // Image.asset(
                        //   'lib/images/vector_login.png',
                        //   height: 40,
                        //   width: 40,
                        // ),
                        const SizedBox(height: 30),

                        // Register text
                        Text('Join our services',
                            style: GoogleFonts.aBeeZee(
                              fontSize: 28,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                        const SizedBox(height: 10),

                        // Create a new account text
                        Text(
                            'Register below with your details',
                            style: GoogleFonts.aBeeZee(
                              fontSize: 19,
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
                        const SizedBox(height: 15),

                        // Password field
                        MyTextField(
                          controller: confirmPasswordController,
                          hintText: 'Confirm Password',
                          obscureText: true,
                        ),
                        const SizedBox(height: 50),

                        // sign in field
                        MyRegisterButton(
                          onTap: signUp,
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