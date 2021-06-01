import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class Conference extends StatefulWidget {
  @override
  _ConferenceState createState() => _ConferenceState();
}

class _ConferenceState extends State<Conference> {

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

  List rooms;

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
    List floors = data['floors'];
    rooms = data['rooms'];

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
                SizedBox(height: 30.0,),
                Container(
                  height: 500.0,
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
                                      thickness: 2.0, 
                                      color: Theme.of(context).primaryColor,
                                      // color: Colors.black,
                                    ),
                                  )
                                ),
                                Text('Floor ${floors[index]['floor_no']}',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 20.0,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10.0, right: 15.0),
                                    child: Divider(
                                      height: 50.0, 
                                      thickness: 2.0, 
                                      color: Theme.of(context).primaryColor,
                                      // color: Colors.black,
                                    ),
                                  )
                                ),
                              ],
                            ),
                            rooms[index].length != 0 ? Container(
                              height: 200.0,
                              // child: Text('${rooms[index]} | ${rooms[index].length}'),
                              child: GridView.count(
                                crossAxisCount: 2,
                                children: List.generate(rooms[index].length, (i) {
                                  Map room = rooms[index][i];
                                  return Text('$room');
                                })
                              ),

                              // child: ListView.builder(
                              //   itemCount: rooms[index].length,
                              //   itemBuilder: (context, i){
                              //     Map room = rooms[index][i];
                              //     return Text('${room['room_type']}');
                              //   },
                              // ),
                            ) :
                            Text('no rooms configured inside this floor'),
                          ],
                        ),
                      );
                    },
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
                          height: 100.0,
                        alignment: Alignment.center,
                        // color: Colors.white,
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
          ],
        ),
      ),
    );
  }
}