import 'package:flutter/material.dart';
import 'package:iot_app_2/Screens/screens.dart';
import 'package:iot_app_2/admin/admin_screens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Professional Organizational Building',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
        primaryColor: Color(0xFF325490),
        brightness: Brightness.light,
        // primaryColor: Color.fromRGBO(50, 84, 144, 100),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/signUp': (context) => SignUpScreen(),
        '/main': (context) => MainMenu(),
        '/conference': (context) => Conference(),
        '/booking': (context) => Booking(),
        '/book': (context) => Book(),
        '/rest': (context) => Rest(),

        '/admin': (context) => Admin(),
        '/users': (context) => Users(),
        '/addFloor': (context) => AddFloor(),
        '/adminRooms': (context) => AdminRoom(),
        '/addRoom': (context) => AddRoom(),
        '/roomDetails': (context) => RoomDetails(),
        // '/device': (context) => AdminDevice(), 
      },
    );
  }
}