import 'package:flutter/material.dart';

class AdminDevice extends StatefulWidget {
  @override
  _AdminDeviceState createState() => _AdminDeviceState();
}

class _AdminDeviceState extends State<AdminDevice> {
  @override
  Widget build(BuildContext context) {

    Map data = ModalRoute.of(context).settings.arguments;
    if (data == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('NOT AUTHORIZED',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) => Theme.of(context).primaryColor)
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/');
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Text('Please Login')
                ),
              ),
            ],
          )
        )
      );
    } else {
      return Container();
    }
  }
}