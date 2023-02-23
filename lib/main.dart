import 'package:dentalapp/pages/auth_page.dart';
import 'package:flutter/material.dart';
<<<<<<<<< Temporary merge branch 1
import 'package:dentalapp/pages/login_page.dart';
=========
>>>>>>>>> Temporary merge branch 2
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }

}

