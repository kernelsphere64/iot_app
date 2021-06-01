import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:iot_app_2/network/server.dart';
import 'common_methods.dart';

class Rest extends StatefulWidget {
  @override
  _RestState createState() => _RestState();
}

class _RestState extends State<Rest> {

  TextStyle btnStyle = TextStyle(
    fontSize: 20.0,
  );

  Timer _timer;
  String _dateTime;

  void _getTime() {
    final String formatterDateTime = DateFormat('dd LLL yyyy hh:mm:ss a').format(DateTime.now()).toString();
    setState(() {
      _dateTime = formatterDateTime;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _timer = new Timer.periodic(Duration(seconds: 1), (Timer timer) => _getTime());
    super.initState();
  }

  List filterRooms(List booking, int id) {
    List temp = [];
    for (var i = 0; i < booking.length; i++) {
      if (booking[i]['room'] == id) {
        temp.add(booking[i]);
      }
    }
    return temp;
  }

  @override
  Widget build(BuildContext context) {

    Map data = ModalRoute.of(context).settings.arguments;
    List floors = data['floors'];
    List rooms = data['rooms'];

    MaterialStateProperty btnBackground = MaterialStateProperty.resolveWith<Color>((states){
      return Theme.of(context).primaryColor;
    });

    return Scaffold(
      body: SingleChildScrollView(
          child: Stack(
          children: [
            Column(
              children: [
                // SizedBox(height: 100.0,),
                // Text('hialksjflksdjflaksj'),C:\Users\Siraj\Desktop\Flutter app\iot_app\iot_app_2\assets\images\bg_main_conf_current_avail.jpg
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: Image.asset('assets/images/bg_rest_current_avail.jpg',
                    fit: BoxFit.cover,
                    color: Color.fromRGBO(255, 255, 255, 0.75),
                    colorBlendMode: BlendMode.modulate,
                  ),
                ),
                // SizedBox(height: 100.0,),
              ],
            ),
            SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(height: 50.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                          child: Icon(Icons.arrow_back_ios_rounded,
                          size: 30.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Column(
                        children: [
                          Container(
                            child: Text('Rest Room',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 25.0,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            child: Text('Availability',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 25.0,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(context, '/');
                        },
                        child: Icon(Icons.logout,
                          size: 30.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 30.0,),
                Text('Current Date/Time: ${_dateTime.toString()}',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(height: 10.0,),
                Container(
                  height: 550.0,
                  child: ListView.builder(
                    itemCount: floors.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10.0, right: 15.0),
                                    child: Divider(
                                      height: 50.0, 
                                      thickness: 3.0, 
                                      // color: Theme.of(context).primaryColor,
                                      color: Colors.redAccent,
                                    ),
                                  )
                                ),
                                Text('Floor ${floors[index]['floor_no']}',
                                  style: TextStyle(
                                    // color: Theme.of(context).primaryColor,
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10.0, right: 15.0),
                                    child: Divider(
                                      height: 50.0, 
                                      thickness: 3.0, 
                                      // color: Theme.of(context).primaryColor,
                                      color: Colors.redAccent,
                                    ),
                                  )
                                ),
                              ],
                            ),
                            rooms[index].length != 0 ? Container(
                              height: 100.0,
                              // child: Text('${rooms[index]} | ${rooms[index].length}'),
                              // child: GridView.count(
                              //   crossAxisCount: 2,
                              //   children: List.generate(rooms[index].length, (i) {
                              //     Map room = rooms[index][i];
                              //     return Center(
                              //       child: ElevatedButton(
                              //         onPressed: () {},
                              //          child: Column(
                              //            children: [
                              //               Text('${room['room_type']}'),
                              //               Text('#${room['room_no']}'),
                              //               Text('${room['current_count']}/${room['max_count']}'),
                              //            ],
                              //          ),
                              //       ),
                              //     );
                              //   })
                              // ),

                              child: ListView.builder(
                                itemCount: rooms[index].length,
                                itemBuilder: (context, i){
                                  Map room = rooms[index][i];
                                  return Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                                      child: ElevatedButton(
                                        style: ButtonStyle(backgroundColor: btnBackground),
                                        onPressed: () async {
                                          print('rest room');
                                          // int roomId = room['id'];
                                          // List bookings = await getTableDetails('bookings');
                                          // List filteredRooms = filterRooms(bookings, roomId);
                                          // print(filteredRooms);
                                          // Navigator.pushNamed(context, '/book', arguments: {
                                          //   'room_details': filteredRooms,
                                          // });
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: 10.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(
                                                children: [
                                                  Text('${room['room_type']}'),
                                                  Text('#${room['room_no']}'),
                                                ],
                                              ),
                                              Text('${room['present_count']}/${room['max_count']}'),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ) :
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(horizontal: 20.0),
                              padding: EdgeInsets.all(10.0),
                              color: Theme.of(context).primaryColor,
                              child: Text('No Rest Rooms available on this Floor',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            // SizedBox(height: 15),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20,),
                Expanded(
                    child: Align(
                    alignment: FractionalOffset.bottomCenter,
                      child: Container(
                        color: Theme.of(context).primaryColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                            onTap: () async {
                              // List floors = await getTableDetails('floors');
                              List rooms = await getTableDetails('rooms');
                              List resRooms = categoriseRooms(floors, rooms, 'CONFERENCE ROOM');
                              print(resRooms);
                              Navigator.pushReplacementNamed(context, '/conference', arguments: {
                                'floors' : floors,
                                'rooms' : resRooms,
                              });
                            },
                              child: Container(
                                color: Theme.of(context).primaryColor,
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Container(
                                  alignment: Alignment.center,
                                  // color: Colors.white,
                                  child: Text('Conference Room availability',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                            ),
                                ),
                              ),
                    ),
                    GestureDetector(
                            onTap: () {
                              print('report');
                              // Navigator.pushNamed(context, '/report');
                            },
                              child: Container(
                                color: Theme.of(context).primaryColor,
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Container(
                                    height: 100.0,
                                  alignment: Alignment.center,
                                  // color: Colors.white,
                                  child: Text('Report an Issue',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
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
                )
              ],
            ),
          ),
        ),
          ],
        ),
      ),
    );
  }
}