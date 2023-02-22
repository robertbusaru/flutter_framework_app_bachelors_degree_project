import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
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
                SizedBox(height: 10),
                // Welcome \n Login to your account
                Text('Welcome',
                    style: GoogleFonts.aBeeZee(
                      fontSize: 32,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )
                ),
                SizedBox(height: 10),
                Text(
                    'Login to your account',
                    style: GoogleFonts.aBeeZee(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )
                ),
                SizedBox(height: 30),

                // Email field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextField(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Password field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextField(
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                // Forgot password?
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                      "Forgot password? ",
                      style: GoogleFonts.aBeeZee(
                        fontSize: 15,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        )
                      ),
                    ]
                ),
                SizedBox(height: 40),

                // sign in field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(30),),
                    child: Center(
                      child: Text('Login',
                          style: GoogleFonts.aBeeZee(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),

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
                SizedBox(height: 30),
                // Or connect with one of those:
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
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

                      Expanded(
                        child:
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // google and facebook login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/images/facebook.png',
                      height: 40,
                      width: 40,
                    ),
                    SizedBox(width: 100),
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