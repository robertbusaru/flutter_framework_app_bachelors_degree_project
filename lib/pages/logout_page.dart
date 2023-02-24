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
                        const Icon(
                          Icons.account_circle_rounded,
                          color: Colors.black,
                          size: 150,
                          semanticLabel: 'Text to announce in accessibility modes',
                        ),
                        const SizedBox(height: 30),
                        // Logged in user text
                        const Text(
                          'Logged as ',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 320),
                            MyLogOutButton(onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const AuthPage()),
                              );
                            },
                          ),
                        const SizedBox(height: 60),
                        const Text(
                          "© 2023 Robert Busaru",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        ],
                      ),
                )
            )
        )
    );
  }
}