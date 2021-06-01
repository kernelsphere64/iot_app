import 'package:flutter/material.dart';
import 'package:iot_app_2/network/server.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final userController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool _clicked = false;
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
            color: Theme.of(context).primaryColor,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(height: 120.0,),
                Hero(
                  tag: 'logo',
                    child: Icon(Icons.account_balance_outlined,
                    size: 80.0, 
                    color: Colors.white,
                  ),
                ),
                // Image.asset('assets/images/logo.png', height: 100.0, width: 100.0, fit: BoxFit.cover,),
                Text('Smart Professional', 
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    letterSpacing: 1.2,
                  ),
                ),
                Text('Organizational Building',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 70,),
                Text('Login with your registered credentials', 
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                    letterSpacing: 1.2,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                  child: TextField(
                    controller: userController,
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
                SizedBox(height: 50.0,),
                GestureDetector(
                  onTap: _clicked ? null : () async {
                    setState(() {
                      _clicked = true;
                    });
                    // print('logging in...');
                    if (userController.text == '' || passController.text == ''){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.grey,
                        content: Text('Enter valid credentials or Register yourself'),
                      ));
                    } else {
                      List users = await getTableDetails('users');
                      print(users);
                      // print(userController.text + passController.text);
                      for (var i = 0; i < users.length; i++) {
                        if (userController.text == users[i]['email_id'] && passController.text == users[i]['password']){
                          if (users[i]['is_verified'] == true) {
                            String user = users[i]['email_id'];
                            Navigator.pushReplacementNamed(context, '/main', arguments: {
                              'user': user,
                            });
                          } else {
                            showDialog(context: context, builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Not verified'),
                                content: Text('You are not verified by the admin, Please contact the administrator.'),
                                actions: [
                                  OutlinedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Ok'),
                                  ),
                                ],
                              );
                            });
                          }
                          
                        }
                      }
                      List admins = await getTableDetails('admins');
                      for (var i = 0; i < admins.length; i++) {
                        if (admins[i]['admin_user'] == userController.text && admins[i]['admin_pass'] == passController.text){
                          List floors = await getTableDetails('floors');
                          Navigator.pushReplacementNamed(context, '/admin', arguments: {
                            'floors': floors,
                          });
                        }
                      }
                    }
                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //   backgroundColor: Colors.grey,
                    //   content: Text('Enter valid credentials or Register yourself'),
                    // ));
                  },
                    child: Container(
                    height: 50.0,
                    margin: EdgeInsets.symmetric(horizontal: 60.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text('Sign me now!',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.0,
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
                        color: Colors.white,
                        child: Text('Don\'t have an account? Sign up!',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
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