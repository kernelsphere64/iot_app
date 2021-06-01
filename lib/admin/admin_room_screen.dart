import 'package:flutter/material.dart';
import 'package:iot_app_2/network/server.dart';
import 'package:iot_app_2/Screens/common_methods.dart';

class AdminRoom extends StatefulWidget {
  @override
  _AdminRoomState createState() => _AdminRoomState();
}

class _AdminRoomState extends State<AdminRoom> {
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
                  child: Text('Please Login', overflow: TextOverflow.ellipsis,)
                ),
              ),
            ],
          )
        )
      );
    } else {

      List rooms = data['rooms'];
      int floor = data['floor'];
      print(rooms);
      print(floor);

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
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                          child: Icon(Icons.arrow_back_ios_rounded,
                          size: 30.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Column(
                        children: [
                          Container(
                            child: Text('Floor ${floor.toString()} | Rooms',
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
                          Navigator.pop(context);
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
                // Text('Current Date/Time: ${_dateTime.toString()}',
                //   style: TextStyle(
                //     fontSize: 15.0,
                //     color: Colors.white,
                //   ),
                // ),
                // SizedBox(height: 20.0,),
                Container(
                  // height: 600.0,
                  height: MediaQuery.of(context).size.height - 200.0,
                  child: rooms.length != 0 ? ListView.builder(
                    itemCount: rooms.length,
                    itemBuilder: (context, index) {
                      Map room = rooms[index];
                      return GestureDetector(
                        onTap: () async {
                          // print(floor['floor_no']);
                          // List rooms = await getTableDetails('rooms');
                          // List resRooms = categoriseRoomsbyFloors(floor['floor_no'], rooms);
                          // print(resRooms);
                          // Navigator.pushNamed(context, '/adminRooms', arguments: {
                          //   'rooms': resRooms,
                          // });
                        },
                          child: GestureDetector(
                            onTap: () async {
                              print('${room['room_type']} ${room['room_no']}');
                              List roomsList = await getTableDetails('rooms');
                              // print(roomsList);
                              // int max = 15;
                              String roomNo = room['room_no'].toString();
                              String roomType = room['room_type'];
                              String maxCap = findMaxCountbyRoomTypeAndRoomNo(roomsList, roomNo, roomType);
                              print(roomNo);
                              print(roomType);
                              print(maxCap);
                              // Navigator.pushNamed(context, '/roomDetails');
                              // Navigator.pushNamed(context, '/addRoom', arguments: {
                              //   'room_no' : roomNo,
                              //   'room_type': roomType,
                              //   'max_capacity': max_capacity,
                              // });
                            },
                            child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                            // color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${room['room_type']}',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text('#${room['room_no']}',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                    // Column(
                                    //   children: [
                                    //     Text(,'${room['room_type']}'
                                    //     overflow: TextOverflow.ellipsis,
                                    //       style: TextStyle(
                                    //         fontSize: 20.0,
                                    //         fontWeight: FontWeight.w500,
                                    //       ),
                                    //     ),
                                    //     Text('#${room['room_no']}',
                                    //     overflow: TextOverflow.ellipsis,
                                    //       style: TextStyle(
                                    //       fontSize: 20.0,
                                    //       fontWeight: FontWeight.w500,
                                    //   ),
                                    //     )
                                    //   ],
                                    // ),
                                    // Text('${room['current_count']}/${room['max_count']}',
                                    //   style: TextStyle(
                                    //     fontSize: 20.0,
                                    //     fontWeight: FontWeight.w500,
                                    //   ),
                                    // )
                                  ],
                                ),
                                Text('devices: ${rooms[index]['deviceId'].length}',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                // Expanded(
                                //     child: Container(
                                //     width: double.infinity,
                                //     height: 50,
                                //       child: ListView.builder(
                                //       scrollDirection: Axis.horizontal,
                                //       itemCount: rooms[index]['deviceId'].length,
                                //       itemBuilder: (context, index2){
                                //         return Text('hi');
                                //       },
                                //     ),
                                //   ),
                                // ),
                                //todo: recent orders wala slider
                              ],
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
                      child: Text('Please add Rooms',
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
                          Navigator.pushNamed(context, '/addRoom', arguments: {
                            'rooms': 1,
                            'floor': floor,
                          });
                        },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.white,
                            ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    // color: Colors.white,
                                    child: Text('+ Add Rooms',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 20.0,
                                        letterSpacing: 1.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
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
}