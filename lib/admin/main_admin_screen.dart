import 'package:flutter/material.dart';
// import 'dart:async';
// import 'package:intl/intl.dart';
import 'package:iot_app_2/network/server_communication.dart';
import 'package:iot_app_2/Screens/common_methods.dart';

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {

  List rooms;
  Future<List> getNotVerifiedUsers(List users) async {
    List temp = [];
    for (var i = 0; i < users.length; i++) {
      if (users[i]['is_verified'] == false) {
        temp.add(users[i]);
      }
    }
    return temp;
  }

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
    }

    List floors = data['floors'];

    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
            color: Theme.of(context).primaryColor,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(height: 50.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Padding(
                    //   padding: EdgeInsets.only(left: 10.0),
                    //   child: GestureDetector(
                    //     onTap: () => Navigator.pop(context),
                    //       child: Icon(Icons.arrow_back_ios_rounded,
                    //       size: 30.0,
                    //       color: Theme.of(context).primaryColor,
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Column(
                        children: [
                          Container(
                            child: Text('Admin | Floors',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // Container(
                          //   child: Text('Availability',
                          //     style: TextStyle(
                          //       color: Theme.of(context).primaryColor,
                          //       fontSize: 25.0,
                          //     ),
                          //     overflow: TextOverflow.ellipsis,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/');
                        },
                        child: Icon(Icons.logout,
                          size: 30.0,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 40.0,),
                GestureDetector(
                  onTap: () async {
                    List users = await getTableDetails('users');
                    List notVerified = await getNotVerifiedUsers(users);
                    print(users);
                    print(notVerified);
                    Navigator.pushNamed(context, '/users', arguments: {
                      'users': notVerified,
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                    child: Text('Pending users',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                // Text('Current Date/Time: ${_dateTime.toString()}',
                //   style: TextStyle(
                //     fontSize: 15.0,
                //     color: Colors.white,
                //   ),
                // ),
                // SizedBox(height: 20.0,),
                Container(
                  // height: 600.0,
                  height: MediaQuery.of(context).size.height - 280.0,
                  child: floors.length != 0 ? ListView.builder(
                    itemCount: floors.length,
                    itemBuilder: (context, index) {
                      Map floor = floors[index];
                      return GestureDetector(
                        onTap: () async {
                          int floorNo = floor['floor_no'];
                          List rooms = await getTableDetails('rooms');
                          List resRooms = categoriseRoomsbyFloors(floor['floor_no'], rooms);
                          List resroomsDevices = await removeDuplicateRoomsAndIntegrateResult(resRooms);
                          print(resroomsDevices);
                          print(floorNo);
                          Navigator.pushNamed(context, '/adminRooms', arguments: {
                            'rooms': resroomsDevices,
                            'floor': floorNo,
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                          // color: Colors.white,
                          child: Text('Floor ${floor['floor_no']}',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                  ) :
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 290.0),
                    // padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 10.0),
                    // color: Colors.white,
                    child: Center(
                      child: Text('Please add Floors',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Align(
                    alignment: FractionalOffset.bottomCenter,
                      child: GestureDetector(
                        onTap: () {
                          print("add floor");
                          Navigator.pushNamed(context, '/addFloor', arguments: {
                            'floor' : 1,
                          });
                        },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.white,
                            ),
                          // color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    // color: Colors.white,
                                    child: Text('+ Add floor',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 20.0,
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                    // GestureDetector(
                    //         onTap: () {
                    //           print('report');
                    //           // Navigator.pushNamed(context, '/report');
                    //         },
                    //           child: Container(
                    //             color: Theme.of(context).primaryColor,
                    //             child: Padding(
                    //               padding: EdgeInsets.all(10.0),
                    //               child: Container(
                    //                 // height: 100.0,
                    //               alignment: Alignment.center,
                    //               // color: Colors.white,
                    //               child: Text('Report an Incident',
                    //                 style: TextStyle(
                    //                   color: Colors.white,
                    //                   fontSize: 15.0,
                    //                   fontWeight: FontWeight.w500,
                    //                 ),
                    //               ),
                    //         ),
                    //             ),
                    //           ),
                    // )
                            ],
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