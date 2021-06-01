import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
// import 'common_methods.dart';
import 'package:iot_app_2/network/server.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'common_methods.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


class Booking extends StatefulWidget {

  const Booking({Key key}) : super(key: key);

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {

  // CalendarController _controller;
  // Map <DateTime, List<dynamic>> _events;
  // List _events;
  // TextEditingController _eventController;

  TextStyle btnStyle = TextStyle(
    fontSize: 20.0,
  );

  Timer _timer;
  String pickedDate;

  // String _dateTime;
  String fromTime;
  List _selectedEvents = [];
  String toTime;

  void _getTime() {
    // final String formatterDateTime = DateFormat('dd LLL yyyy hh:mm:ss a').format(DateTime.now()).toString();
    setState(() {
      // _dateTime = formatterDateTime;
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
  int getOnDateEventCount;
  String toDateTime;
  DateTime _selectedDay;
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  List getAlternateTime(List times) {
    List temp = [];
    DateTime prevFromTime;
    DateTime prevToTime;
    // DateTime now = DateTime.now();
    for (var i = 0; i < times.length; i++) {
      DateTime fromTime = DateTime.tryParse(times[i]['from_date_time']);
      DateTime toTime = DateTime.tryParse(times[i]['to_date_time']);
      // print('fromTime');
      // print(fromTime);
      String fromTimeToStr = DateFormat('hh:mm a').format(fromTime);
      String toTimeToStr = DateFormat('hh:mm a').format(toTime);
      if (i == 0) {
        temp.add('12:00 AM - $fromTimeToStr');
      } else {
        DateTime _fromTime = DateTime.tryParse(times[i]['from_date_time']);
        DateTime _toTime = DateTime.tryParse(times[i]['to_date_time']);
        int diffFromTime = prevFromTime.compareTo(_fromTime);
        int diffToTime = prevToTime.compareTo(_toTime);

        print(diffFromTime);
        print(diffToTime);
      }
      
      if (i == times.length - 1) {
        temp.add('$toTimeToStr - 11:59 PM');
      }
      prevFromTime = fromTime;
      prevToTime = toTime;
      // temp.add('12:00 AM - $fromTime');
      
    }
    // print('temp');
    // print(temp);
    // print('times');
    // print(times[0]['from_date_time']);
    return temp;
  }

  // getOnDateEvents(DateTime today, List details) async {
  //   List bookings = await getTableDetails('bookings');
  //   List details = filterRooms(bookings, int.parse(roomId));
  //   getSelectedEvents(DateTime.now(), details);
  // }

  @override
  void initState() {
    _timer = new Timer.periodic(Duration(seconds: 1), (Timer timer) => _getTime());
    // _controller = CalendarController;0
    getOnDateEventCount = 0;
    // _eventController = TextEditingController();
    
    // _events = {};
    // _selectedEvents = [];
    super.initState();
  }

  void getSelectedEvents(DateTime tapDay, List details) {
    // List tempList = [];
    _selectedEvents.clear();
    // print('details');
    // print(details);
    // print(tapDay.day.toString() + tapDay.month.toString() + tapDay.year.toString());
    // print('room details in getselectedevents');
    // print(details);
    for (var detail in details) {
      DateTime temp = DateTime.tryParse(detail["from_date_time"]);
      if (temp.day == tapDay.day && temp.month == tapDay.month && temp.year == tapDay.year){
        Map tempDetail = detail;
        // String fdt = DateFormat('hh:mm a').format(DateTime.tryParse(detail['from_date_time']));
        // String tdt = DateFormat('hh:mm a').format(DateTime.tryParse(detail['to_date_time']));
        // print(fdt);
        // print(tdt);
        tempDetail['from_date_time'] = DateFormat('hh:mm a').format(DateTime.tryParse(detail['from_date_time']));
        tempDetail['to_date_time'] = DateFormat('hh:mm a').format(DateTime.tryParse(detail['to_date_time']));
        // print(detail);
        // print(tempDetail);
        // List _events = getAlternateTime();
        // tempList.add(tempDetail);
        _selectedEvents.add(detail);
        // String fdt = detail['from_date_time'];
      }
    }
    // print(tempList);
    // _selectedEvents = getAlternateTime(tempList);
    setState(() {
      // ignore: unnecessary_statements
      _selectedEvents;
    });
    // print('_selectedEvents in getselectedevents');
    // print(_selectedEvents);
  }
  
  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }
  
  @override
  Widget build(BuildContext context) {

    Map data = ModalRoute.of(context).settings.arguments;
    List roomDetails = data['room_details'];
    String roomId = data['room_id'].toString();
    String user = data['user'];
    int roomMaxCount = data['room_count'];
    String rno = data['rno'].toString();
    if (getOnDateEventCount == 0) {
      getSelectedEvents(DateTime.now(), roomDetails);
      getOnDateEventCount += 1;
    }

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

    // final TextButton cancelBtn = TextButton(
    //   child: Text('Cancel'),
    //   onPressed: () {
    //     Navigator.pop(context);
    //   },
    // );

    // final TextButton okBtn = TextButton(
    //   child: Text('OK'),
    //   onPressed: () async {
    //     print(fromDateTime);
    //     print(toDateTime);
    //     bool ret = await postBooking(fromDateTime, toDateTime, roomId.toString(), user, 'Meeting');
    //     if (ret) {
    //       Navigator.pop(context);
    //       List bookings = await getTableDetails('bookings');
    //       List filteredRooms = filterRooms(bookings, roomId);
    //       print(filteredRooms);
    //       print(roomId);
    //       print(user);
    //       Navigator.pushReplacementNamed(context, '/book', arguments: {
    //         'room_details': filteredRooms,
    //         'room_id': roomId,
    //         'user': user,
    //       });
    //     } else {
    //       print('not found');
    //       Navigator.pop(context);
    //     }
    //   },
    // );

    // AlertDialog bookAlert = AlertDialog(
    //   title: Text('Booking Conference Room'),
    //   content: Text('Do you want to Book Conference Room.\nFrom $fromTime to $toTime'),
    //   actions: [
    //     cancelBtn,
    //     okBtn,
    //   ],
    // );

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
                                child: Text('Booking | #$rno',
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
                    // SizedBox(height: 30.0,),
                    // Text('Current Date/Time: ${_dateTime.toString()}',
                    //   style: TextStyle(
                    //     fontSize: 15.0,
                    //     color: Theme.of(context).primaryColor,
                    //   ),
                    // ),
                    // SizedBox(height: 10.0,),
                    //todo: do in this area
                    Container(
                      height: 650.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.0),
                            margin: EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: TableCalendar( 
                              firstDay: DateTime.now(),
                              lastDay: DateTime.now().add(Duration(days: 365,),),
                              focusedDay: _focusedDay,
                              calendarFormat: _calendarFormat,
                              startingDayOfWeek: StartingDayOfWeek.monday,
                              calendarStyle: CalendarStyle(
                                holidayTextStyle: TextStyle(
                                  color: Colors.red,
                                ),
                                // todayDecoration: BoxDecoration(
                                //   color: Theme.of(context).primaryColor,
                                //   backgroundBlendMode: BlendMode.lighten
                                // ),
                                // selectedDecoration: BoxDecoration(
                                //   color: Theme.of(context).primaryColor,
                                //   borderRadius: BorderRadius.circular(10.0)
                                // ),
                                weekendTextStyle: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600
                                  // backgroundColor: Colors.red
                                ),
                                canMarkersOverflow: true,
                                defaultTextStyle: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  // fontSize: 15.0,
                                ),
                              ),
                              selectedDayPredicate: (day) {
                                // print(day);
                                return isSameDay(_selectedDay, day);
                              },
                              onDaySelected: (selectedDay, focusedDay) async {
                                // print(roomDetails);
                                
                                List bookings = await getTableDetails('bookings');
                                List filteredRooms = filterRooms(bookings, int.parse(roomId));
                                getSelectedEvents(focusedDay, filteredRooms);
                                // print(selectedDay);
                                setState(() {
                                  _selectedDay = selectedDay;
                                  _focusedDay = focusedDay;
                                });
                              },
                              onFormatChanged: (format) {
                                _calendarFormat = CalendarFormat.twoWeeks;
                              },
                              onPageChanged: (focusedDay) {
                                // print(focusedDay);
                                _focusedDay = focusedDay;
                              },
                              eventLoader: (day) {
                                return [];
                              },
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: _selectedEvents.length > 0 ? ListView.builder(
                                itemCount: _selectedEvents.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                                    // height: 20.0,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      // color: Colors.grey[500],
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(10.0),
                                      // border: Border(
                                      //   bottom: BorderSide(color: Colors.red, width: 3.0),
                                      //   top: BorderSide(color: Colors.red, width: 3.0),
                                      //   right: BorderSide(color: Colors.red, width: 3.0),
                                      //   left: BorderSide(color: Colors.red, width: 3.0),
                                      // )
                                    ),
                                    child: Center(child: 
                                      Text('${_selectedEvents[index]['from_date_time']} - ${_selectedEvents[index]['to_date_time']}      BOOKED',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )
                                    ),
                                  );
                                },
                              ) :
                              Center(
                                child: Container(
                                  width: double.infinity,
                                  color: Theme.of(context).primaryColor,
                                  margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                                  child: Text('No bookings on this date',
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      color: Colors.greenAccent,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              )
                            ),
                          )
                        ],
                      ),
                    ),
                    // Container(
                    //     child: TableCalendar(
                    //       firstDay: DateTime.now(),
                    //       lastDay: DateTime.now().add(Duration(days: 365,),),
                    //       focusedDay: DateTime.now(),
                    //     ),
                    //   ),

                    // SizedBox(height: 25,),
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
                                  print(roomDetails);
                                  print(roomId);
                                  print(user);
                                  Navigator.pushNamed(context, '/book', arguments: {
                                    'room_id' : roomId,
                                    'room_count': roomMaxCount,
                                    'user': user,
                                    'rno': rno,
                                  });
                                  // if (pickedDate == null || fromTime == null || toTime == null){
                                  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  //     content: Text('Please select valid Date and Times'),
                                  //     backgroundColor: Colors.grey,
                                  //   ));
                                  // } else {
                                  //   // print(pickedDate);
                                  //   // print(fromTime);
                                  //   // print(toTime);
                                  //   // [{id: 1, from_date_time: 2021-05-07T00:24:42Z, to_date_time: 2021-05-07T18:00:00Z, description: Meeting, room: 1, user: ansariakramobaid@gmail.com}]
                                  //   fromDateTime = pickedDate + 'T' + fromTime + 'Z';
                                  //   toDateTime = pickedDate + 'T' + toTime + 'Z';
                                  //   print(fromDateTime);
                                  //   print(toDateTime);
                                  //   print('description');
                                  //   print('$roomId');
                                  //   print('$user');
                                  //   showDialog(
                                  //     context: context, 
                                  //     builder: (BuildContext context) {
                                  //       return bookAlert;
                                  //     }
                                  //   );
                                  // }
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