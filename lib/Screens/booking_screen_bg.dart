import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'common_methods.dart';
import 'package:iot_app_2/network/server.dart';
import 'package:intl/intl.dart';
import 'dart:async';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


class Booking extends StatefulWidget {
  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {

  TextStyle btnStyle = TextStyle(
    fontSize: 20.0,
  );

  Timer _timer;
  String pickedDate;

  String _dateTime;
  String fromTime;
  String toTime;

  void _getTime() {
    final String formatterDateTime = DateFormat('dd LLL yyyy hh:mm:ss a').format(DateTime.now()).toString();
    setState(() {
      _dateTime = formatterDateTime;
    });
  }

  String convertTimeOfDay(TimeOfDay tod) {
    final now = DateTime.now();
    // final dt = DateTime(tod.hour, tod.minute);
    final format = DateFormat('HH:mm:ss').format(DateTime(now.year, now.minute, now.second, tod.hour, tod.minute));
    // print(format);
    return format;
    // return format.format(dt);
  }

  List rooms;
  String fromDateTime;
  String toDateTime;

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
  
  @override
  Widget build(BuildContext context) {

    Map data = ModalRoute.of(context).settings.arguments;
    List roomDetails = data['room_details'];
    int roomId = data['room_id'];
    String user = data['user'];

    // MaterialStateProperty btnBackground = MaterialStateProperty.resolveWith<Color>((states){
    //   return Theme.of(context).primaryColor;
    // });

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

    final TextButton cancelBtn = TextButton(
      child: Text('Cancel'),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    final TextButton okBtn = TextButton(
      child: Text('OK'),
      onPressed: () async {
        print(fromDateTime);
        print(toDateTime);
        bool ret = await postBooking(fromDateTime, toDateTime, roomId.toString(), user, 'Meeting');
        if (ret) {
          Navigator.pop(context);
          List bookings = await getTableDetails('bookings');
          List filteredRooms = filterRooms(bookings, roomId);
          print(filteredRooms);
          print(roomId);
          print(user);
          Navigator.pushReplacementNamed(context, '/book', arguments: {
            'room_details': filteredRooms,
            'room_id': roomId,
            'user': user,
          });
        } else {
          print('not found');
          Navigator.pop(context);
        }
      },
    );

    AlertDialog bookAlert = AlertDialog(
      title: Text('Booking Conference Room'),
      content: Text('Do you want to Book Conference Room.\nFrom $fromTime to $toTime'),
      actions: [
        cancelBtn,
        okBtn,
      ],
    );

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
                                child: Text('Booking',
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
                    // SizedBox(height: 10.0,),
                    //todo: do in this area
                    Container(
                      height: 550.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.0,),
                          Container(
                            margin: EdgeInsets.only(left: 20.0,),
                            child: Text('Bookings',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            height: 300.0,
                            child: roomDetails.length > 0 ? ListView.builder(
                              itemCount: roomDetails.length,
                              itemBuilder: (context, index) {
                                Map details = roomDetails[index];
                                // String fromDate = DateFormat('dd LLL yyyy hh:mm:ss a').format(DateTime.now()).toString();
                                // String toDate = DateFormat('dd LLL yyyy hh:mm:ss a').format(details['to_date_time']).toString();

                                // print('dates');
                                // print(fromDate);
                                // print(toDate);

                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                  margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('From: ${details['from_date_time'].toString().split('T')[0]} ${details['from_date_time'].toString().split('T')[1].split('Z')[0]}',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text('To:      ${details['to_date_time'].toString().split('T')[0]} ${details['to_date_time'].toString().split('T')[1].split('Z')[0]}',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Text('Booked by: ${details['user']}',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300
                                        ),
                                      ),
                                      // Text('${roomDetails[index]}'
                                      // ),
                                    ],
                                  ),
                                );
                              },
                            ) : Center(
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text('Not booked by any user',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              child: Container(
                              // height: 50.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 20.0,),
                                    child: Text('Book Conference Room',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      // textAlign: TextAlign.left,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2025),
                                      ).then((value) {
                                        setState(() {
                                          pickedDate = value.toString().substring(0,10);
                                        });
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Pick Date:',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text('${pickedDate == null ? 'Tap to pick a Date' : pickedDate.toString()}',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                        // initialDate: DateTime.now(),
                                        // firstDate: DateTime.now(),
                                        // lastDate: DateTime(2025),
                                      ).then((value) {
                                        setState(() {
                                          fromTime = convertTimeOfDay(value);
                                          // fromTime = value.hour.toString() + '-' + value.minute.toString();
                                        });
                                      });
                                    },
                                      child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('From Time:',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Expanded(
                                              child: Text('${fromTime == null ? 'Pick From Time' : fromTime.toString()}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                        // initialDate: DateTime.now(),
                                        // firstDate: DateTime.now(),
                                        // lastDate: DateTime(2025),
                                      ).then((value) {
                                        setState(() {

                                          toTime = convertTimeOfDay(value);
                                          // value.format(context)
                                        });
                                      });
                                    },
                                      child: Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('To Time:',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Expanded(
                                              child: Text('${toTime == null ? 'Pick To Time' : toTime.toString()}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // CupertinoDatePicker(
                                  //   onDateTimeChanged: (date) {
                                  //     print('$date');
                                  //   },
                                  //   backgroundColor: Theme.of(context).primaryColor,
                                  //   initialDateTime: DateTime.now(),
                                  //   use24hFormat: false,
                                  // )
                                  // TextButton(
                                  //   onPressed: () {
                                  //     DatePicker.showTime12hPicker(
                                  //       context,
                                  //       showTitleActions: true,
                                  //       // minTime: DateTime.now(),
                                  //       onConfirm: (time) {
                                  //         print('$time');
                                  //       },
                                  //       currentTime: DateTime.now(),
                                  //     );
                                  //   },
                                  //   child: Text('Pick Time'),
                                  // )
                                ],
                              ),
                            ),
                          )
                          // Center(
                          //   child: Text('$roomDetails',
                          //     style: TextStyle(
                          //       fontSize: 20.0,
                          //       color: Theme.of(context).primaryColor,
                          //     ),
                          //   ),
                          // ),
                        ],
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
                                  if (pickedDate == null || fromTime == null || toTime == null){
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text('Please select valid Date and Times'),
                                      backgroundColor: Colors.grey,
                                    ));
                                  } else {
                                    // print(pickedDate);
                                    // print(fromTime);
                                    // print(toTime);
                                    // [{id: 1, from_date_time: 2021-05-07T00:24:42Z, to_date_time: 2021-05-07T18:00:00Z, description: Meeting, room: 1, user: ansariakramobaid@gmail.com}]
                                    fromDateTime = pickedDate + 'T' + fromTime + 'Z';
                                    toDateTime = pickedDate + 'T' + toTime + 'Z';
                                    print(fromDateTime);
                                    print(toDateTime);
                                    print('description');
                                    print('$roomId');
                                    print('$user');
                                    showDialog(
                                      context: context, 
                                      builder: (BuildContext context) {
                                        return bookAlert;
                                      }
                                    );
                                  }
                                  // List rooms = await getTableDetails('rooms');
                                  // List resRooms = categoriseRooms(floors, rooms, 'REST ROOM');
                                  // Navigator.pushReplacementNamed(context, '/rest', arguments: {
                                  //   'floors': floors,
                                  //   'rooms': resRooms,
                                  // });
                                },
                                child: Container(
                                  color: Theme.of(context).primaryColor,
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Container(
                                      alignment: Alignment.center,
                                      // color: Colors.white,
                                      child: Text('Book Conference Room',
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
                              // GestureDetector(
                              //   onTap: () {
                              //     print('report');
                              //     // Navigator.pushNamed(context, '/report');
                              //   },
                              //   child: Container(
                              //     color: Theme.of(context).primaryColor,
                              //     child: Padding(
                              //       padding: EdgeInsets.all(10.0),
                              //       child: Container(
                              //         // height: 100.0,
                              //         alignment: Alignment.center,
                              //         // color: Colors.white,
                              //         child: Text('Report an Incident',
                              //           style: TextStyle(
                              //             color: Colors.white,
                              //             fontSize: 15.0,
                              //             fontWeight: FontWeight.w500,
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // )
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