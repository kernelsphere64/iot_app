import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:iot_app_2/network/server.dart';
import 'common_methods.dart';

class Conference extends StatefulWidget {
  @override
  _ConferenceState createState() => _ConferenceState();
}

class _ConferenceState extends State<Conference> {

  TextStyle btnStyle = TextStyle(
    fontSize: 20.0,
  );

  // Timer _timer;

  // ignore: unused_field
  String _dateTime;
  void _getTime() {
    final String formatterDateTime = DateFormat('dd LLL yyyy hh:mm:ss a').format(DateTime.now()).toString();
    setState(() {
      _dateTime = formatterDateTime;
    });
  }

  List rooms;

  @override
  void dispose() {
    // _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    // _timer = new Timer.periodic(Duration(seconds: 1), (Timer timer) => _getTime());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Map data = ModalRoute.of(context).settings.arguments;
    List floors = data['floors'];
    rooms = data['rooms'];
    String user = data['user'];

    MaterialStateProperty btnBackground = MaterialStateProperty.resolveWith<Color>((states){
      return Theme.of(context).primaryColor;
    });

    // _buildfloor(Map roomDetails) {
    //   return Container(
    //     height: 100.0,
    //     width: 100.0,
    //     child: ElevatedButton(
    //       onPressed: () {},
    //         child: Column(
    //         children: [
    //           Text('${roomDetails['room_type']}'),
    //           Text('#${roomDetails['room_no']}'),
    //           Text('${roomDetails['current_count']}/${roomDetails['max_count']}'),
    //         ],
    //       ),
    //     ),
    //   );
    // }

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
                  child: Image.asset('assets/images/bg_main_conf_current_avail.jpg',
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
                            child: Text('Conference Room',
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
                // Text('Current Date/Time: ${_dateTime.toString()}',
                //   style: TextStyle(
                //     fontSize: 15.0,
                //     color: Theme.of(context).primaryColor,
                //   ),
                // ),
                // SizedBox(height: 10.0,),
                Container(
                  height: 580.0,
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
                              height: 150.0,
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
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                                          child: ElevatedButton(
                                            style: ButtonStyle(backgroundColor: btnBackground),
                                            onPressed: () async {
                                              int roomId = room['id'];
                                              int rno = room['room_no'];
                                              int roomMaxCount = room['max_count'];
                                              List bookings = await getTableDetails('bookings');
                                              List filteredRooms = filterRooms(bookings, roomId);
                                              print('filteredRooms');
                                              print(filteredRooms);
                                              print('roomId $roomId');
                                              print('user');
                                              print(user);
                                              // print(rooms);
                                              Navigator.pushNamed(context, '/booking', arguments: {
                                                'room_details': filteredRooms,
                                                'room_id': roomId,
                                                'room_count': roomMaxCount,
                                                'user': user,
                                                'rno': rno,
                                              });
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
                                                  // Text('${room['present_count']}/${room['max_count']}'),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                      ],
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
                              child: Text('No Conference Roos available on this Floor',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 25,),
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
                              List rooms = await getTableDetails('rooms');
                              List resRooms = categoriseRooms(floors, rooms, 'REST ROOM');
                              Navigator.pushReplacementNamed(context, '/rest', arguments: {
                                'floors': floors,
                                'rooms': resRooms,
                              });
                            },
                              child: Container(
                                color: Theme.of(context).primaryColor,
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Container(
                                  alignment: Alignment.center,
                                  // color: Colors.white,
                                  child: Text('Rest Room availability',
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
                                    // height: 100.0,
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