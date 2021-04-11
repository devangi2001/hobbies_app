import 'package:flutter/material.dart';
import 'package:hobbies/auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //Creates and initializes the binding (interact with the Flutter engine).(isko note pad me save kar lena, yaha se delete kar dena)
  await Firebase
      .initializeApp(); // to connect Firebase with Flutter we have to initialise Firebase before using it.(isko bhi)
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hobbies App',
      theme: ThemeData.dark(),
      home: AuthenticationScreen(),
    );
  }
}

