import 'package:flutter/material.dart';
import 'package:iot_app_2/network/server_communication.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final userController = TextEditingController();
  final mobileController = TextEditingController();
  final passController = TextEditingController();
  final cnfPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Theme.of(context).primaryColor,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100.0,),
              Hero(
                tag: 'logo',
                  child: Icon(Icons.account_balance_outlined,
                  size: 120.0, 
                  color: Colors.white,
                ),
              ),
              Text('Sign Up', 
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  // fontFamily: 'Roboto',
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 20.0,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                child: TextField(
                  controller: userController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email, size: 30.0),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: mobileController,
                  // obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Mobile No.',
                    prefixIcon: Icon(Icons.phone, size: 30.0),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                child: TextField(
                  controller: passController,
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock, size: 30.0),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                child: TextField(
                  controller: cnfPassController,
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                    fillColor: Colors.white,
                    filled: true,
                    labelText: 'Confirm Password',
                    prefixIcon: Icon(Icons.lock, size: 30.0),
                  ),
                ),
              ),
              Expanded(
                  child: Align(
                  alignment: FractionalOffset.bottomCenter,
                    child: GestureDetector(
                    onTap: () async {
                      if (userController.text == '' ||
                          mobileController.text == '' ||
                          passController.text == '' ||
                          cnfPassController.text == '' )
                          {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.grey,
                              content: Text('Enter valid details'),
                            ));
                          } else {
                            if (passController.text == cnfPassController.text) {
                              print(userController.text);
                              print(mobileController.text);
                              print(passController.text);
                              bool success = await postUser(userController.text, mobileController.text, passController.text);
                              if (success) {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text('User registered please login'),
                                  backgroundColor: Colors.grey,
                                ));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text('Please try after some time'),
                                  backgroundColor: Colors.grey,
                                ));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.grey,
                                content: Text('Passwords not match'),
                              ));
                            }
                          }
                      // Navigator.pop(context);
                    },
                    child: Container(
                      height: 80.0,
                      alignment: Alignment.center,
                      color: Colors.white,
                      child: Text('Register',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 30.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}