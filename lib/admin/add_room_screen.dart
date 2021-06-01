import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iot_app_2/network/server_communication.dart';
import 'package:iot_app_2/Screens/common_methods.dart';

class AddRoom extends StatefulWidget {
  @override
  _AddRoomState createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
  
  String _chosenValue;
  final room = TextEditingController();
  final deviceId = TextEditingController();
  final maxCap = TextEditingController();

  final enterValieDataSSB = SnackBar(
    content: Text('Enter valid data of the room',),
    backgroundColor: Colors.grey,
  );

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

      Map data = ModalRoute.of(context).settings.arguments;
      int floor = data['floor'];

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
                            child: Text('Add Room',
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
                    // Padding(
                    //   padding: EdgeInsets.only(right: 20.0),
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       Navigator.pushReplacementNamed(context, '/');
                    //     },
                    //     child: Icon(Icons.logout,
                    //       size: 30.0,
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // )
                  ],
                ),
                SizedBox(height: 40.0,),
                Container(
                  height: MediaQuery.of(context).size.height - 200.0,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                        child: Container(
                          child: TextField(
                            controller: room,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: 'Room No.',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      Container(
                        width: double.infinity,
                        height: 70.0,
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 30.0),
                        child: Center(
                          child: DropdownButton<String>(
                            focusColor: Colors.white,
                            value: _chosenValue,
                            style: TextStyle(color: Theme.of(context).primaryColor, fontFamily: 'Roboto'),
                            items: <String>[
                              'CONFERENCE ROOM',
                              'REST ROOM',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              );
                            }).toList(),
                            hint: Text('Please choose a type of room',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20.0,
                                fontFamily: 'Roboto',
                              ),
                            ),
                            onChanged: (String value) {
                              setState(() {
                                _chosenValue = value;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      // [{deviceId: [C00001, C00002], present_count: 0, max_count: 15, building: Building 1, floor: 1}]
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                        child: Container(
                          child: TextField(
                            controller: deviceId,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: 'device ID',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                        child: Container(
                          child: TextField(
                            controller: maxCap,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: 'Maximum Capacity',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0,),
                    ],
                  ),
                ),
                Expanded(
                    child: Align(
                    alignment: FractionalOffset.bottomCenter,
                      child: GestureDetector(
                        onTap: () async {
                          // List rooms = await getTableDetails('rooms');
                          // List resRooms = categoriseRoomsbyFloors(floor, rooms);
                          // List resroomsDevices = await removeDuplicateRoomsAndIntegrateResult(resRooms);
                          // print(resroomsDevices);
                          if (room.text == '' ||
                              _chosenValue == null ||
                              deviceId.text == '' ||
                              maxCap.text == ''
                          ) {
                            ScaffoldMessenger.of(context).showSnackBar(enterValieDataSSB);
                          } else {
                            print(room.text);
                            print(_chosenValue);
                            print(deviceId.text);
                            print(maxCap.text);
                            print(floor);
                            bool ret = await putRoom(room.text, _chosenValue, deviceId.text, maxCap.text, floor);
                            if (ret) {
                              List rooms = await getTableDetails('rooms');
                              List resRooms = categoriseRoomsbyFloors(floor, rooms);
                              List resroomsDevices = await removeDuplicateRoomsAndIntegrateResult(resRooms);
                              print(resroomsDevices);
                              Navigator.pop(context);
                              Navigator.pushReplacementNamed(context, '/adminRooms', arguments: {
                                'rooms': resroomsDevices,
                                'floor': floor,
                              });
                            }
                          }
                          // Navigator.pop(context);
                          
                          // Navigator.popAndPushNamed(context, '/adminRooms', arguments: {
                          //   'rooms': 1
                          // });
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
                                    child: Text('Submit',
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
}