import 'package:dentalapp/pages/auth_page.dart';
import 'package:dentalapp/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogoutPage extends StatefulWidget{
  const LogoutPage({super.key});

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage>{
  // text editing controllers
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserOut(){
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: ((context) => const AuthPage())
        )
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
                  MaterialPageRoute(builder: (context) => HomePage()),
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
                        const SizedBox(height: 500),
                          IconButton(
                            onPressed: signUserOut,
                            icon: const Icon(Icons.logout),
                            color: Colors.black,
                          )
                        ],
                        // Or connect with one of those:
                      ),
                )
            )
        )
    );
  }
}