import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cnfPasswordController = TextEditingController();
  final mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 120.0,),
              Hero(
                tag: 'logo',
                  child: Icon(Icons.account_balance_outlined,
                  size: 100.0, 
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text('Sign Up', 
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 30.0,
                  letterSpacing: 1.2,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                child: TextField(
                  controller: emailController,
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
                  controller: mobileController,
                  obscureText: true,
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
                  controller: passwordController,
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
                  controller: cnfPasswordController,
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
                    onTap: () {
                      print('register');
                      print(emailController.text);
                      print(mobileController.text);
                      print(passwordController.text);
                      print(cnfPasswordController.text);
                    },
                    child: Container(
                      height: 80.0,
                      alignment: Alignment.center,
                      color: Theme.of(context).primaryColor,
                      child: Text('Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
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