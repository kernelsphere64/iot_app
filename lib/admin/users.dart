import 'package:flutter/material.dart';
import 'package:iot_app_2/network/server_communication.dart';
import 'dart:async';
import 'package:iot_app_2/Screens/common_methods.dart';

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {

  List users;
  Timer _reloadTime;

  Future<void> reload() async {
    // List reloadUsers();
    // List _usersNew = await getTableDetails('users');
    // print('reload users');
    // print(_usersNew);
    // users = await getNotVerifiedUsers(_usersNew);
    // print(users);
    // setState(() {
    // });
  }

  @override
  void dispose() {
    _reloadTime.cancel();
    super.dispose();
  }
  @override
  void initState() {
    _reloadTime = Timer.periodic(Duration(seconds: 10), (Timer t) => reload());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Map data = ModalRoute.of(context).settings.arguments;
    users = data['users'];
    print('users in build');
    print(users);
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Theme.of(context).primaryColor,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(height: 50.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {Navigator.pop(context);},
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Icon(Icons.arrow_back_ios, color: Colors.white, size: 25.0,)
                    )
                  ),
                  Container(
                    child: Text(
                      'Pending users',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    Map user = users[index];
                    return GestureDetector(
                      onTap: () {
                        Widget cancelBtn = OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        );
                        Widget allowBtn = OutlinedButton(
                          onPressed: () async {
                            String _id = user['id'].toString();
                            String _emailId = user['email_id'];
                            String _password = user['password'];
                            String _mob = user['mobile_no'].toString();
                            await allowUser(_id, _emailId, _password, _mob);
                            List _usersNew2 = await getTableDetails('users');
                            List nv = await getNotVerifiedUsers(_usersNew2);
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(context, '/users', arguments: {
                              'users': nv,
                            });
                          },
                          child: Text('Allow'),
                        );
                        showDialog(context: context, builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('User verification details'),
                            content: Text('${user['email_id']}\nMobile No.: ${user['mobile_no']}\nCreated:       ${user['created']}'),
                            actions: [
                              cancelBtn,
                              allowBtn,
                            ],
                          );
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        child: Row(
                          children: [
                            Container(
                              height: 60.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text('${user['email_id']}',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 20.0,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text('created account on: ${user['created']}',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 14.0,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Container(
                            //   padding: EdgeInsets.all(10.0),
                            //   margin: EdgeInsets.all(10.0),
                            //   color: Colors.green,
                            //   child: Icon(Icons.check, color: Colors.white,),
                            // ),
                            // Container(
                            //   padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                            //   margin: EdgeInsets.all(10.0),
                            //   color: Colors.red,
                            //   child: Text('X',
                            //     style: TextStyle(
                            //       fontSize: 18.0,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}