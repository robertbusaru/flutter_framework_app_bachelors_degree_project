import 'package:dentalapp/components/my_logout_button.dart';
import 'package:dentalapp/pages/home_page.dart';
import 'package:flutter/material.dart';

import 'auth_page.dart';

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
                            MyLogOutButton(onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const AuthPage()),
                              );
                            },
                          ),
                        ],
                      ),
                )
            )
        )
    );
  }
}