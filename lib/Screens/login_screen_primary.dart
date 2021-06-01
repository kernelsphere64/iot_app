import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(height: 120.0,),
                Hero(
                  tag: 'logo',
                    child: Icon(Icons.account_balance_outlined,
                    size: 80.0, 
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                // Image.asset('assets/images/logo.png', height: 100.0, width: 100.0, fit: BoxFit.cover,),
                Text('Smart Professional', 
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 30.0,
                    letterSpacing: 1.2,
                  ),
                ),
                Text('Organizational Building',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 30.0,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 70,),
                Text('Login with your registered credentials', 
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 20.0,
                    letterSpacing: 1.2,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                      fillColor: Colors.white,
                      filled: true,
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.account_box_rounded, size: 30.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                  child: TextField(
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
                SizedBox(height: 40.0,),
                GestureDetector(
                  onTap: () {},
                    child: Container(
                    height: 50.0,
                    margin: EdgeInsets.symmetric(horizontal: 60.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text('Sign me now!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Align(
                    alignment: FractionalOffset.bottomCenter,
                      child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/signUp');
                      },
                        child: Container(
                          height: 80.0,
                        alignment: Alignment.center,
                        color: Theme.of(context).primaryColor,
                        child: Text('Don\'t have an account? Sign up!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }
}