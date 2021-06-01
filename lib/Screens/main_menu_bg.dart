import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:iot_app_2/network/server_communication.dart';
import 'common_methods.dart';
import 'package:url_launcher/url_launcher.dart';

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {

  TextStyle btnStyle = TextStyle(
    fontSize: 20.0,
  );

  // static const _surveyUrl = 'https://flutter.dev';
  static const _surveyUrl = 'https://arcg.is/159iqH';
  Timer _timer;

  String _dateTime;
  void _getTime() {
    final String formatterDateTime = DateFormat('dd LLL yyyy hh:mm:ss a').format(DateTime.now()).toString();
    setState(() {
      _dateTime = formatterDateTime;
    });
  }
  int _counter;
  bool isConferenceButtonEnabled;
  bool isRestButtonEnabled;
  bool isReportButtonEnabled;

  @override
  void dispose() {
    _timer.cancel();
    print('dispose');
    super.dispose();
  }

  @override
  void initState() {
    print('init');
    super.initState();
    _counter = 0;
    isConferenceButtonEnabled = true;
    isRestButtonEnabled = true;
    isReportButtonEnabled = true;
    _timer = new Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
  }

  @override
  Widget build(BuildContext context) {

    Map data = ModalRoute.of(context).settings.arguments;
    String user = data['user'];
    if (_counter != 0) {
      setState(() {
        isConferenceButtonEnabled = true;
        isRestButtonEnabled = true;
        isReportButtonEnabled = true;
      });
    }

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
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text('Main Menu',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 30.0,
                        ),
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
                SizedBox(height: 120.0,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.0),
                  child: Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: btnBackground),
                      onPressed: !isConferenceButtonEnabled ? () {print('null');} : () async {
                        setState(() {
                          isConferenceButtonEnabled = false;
                          isRestButtonEnabled = false;
                          isReportButtonEnabled = false;
                        });
                        _counter += 1;
                        List floors = await getTableDetails('floors');
                        List rooms = await getTableDetails('rooms');
                        List resRooms = categoriseRooms(floors, rooms, 'CONFERENCE ROOM');
                        print('user');
                        print(resRooms);
                        print(user);
                        Navigator.pushNamed(context, '/conference', arguments: {
                          'floors' : floors,
                          'rooms' : resRooms,
                          'user' : user,
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: Column(
                          children: [
                            Text('Conference Rooms', style: btnStyle, overflow: TextOverflow.ellipsis,),
                            Text('Availability / Reservations', style: btnStyle, overflow: TextOverflow.ellipsis,)
                          ],
                        ),
                      )
                    ),
                  ),
                ),
                SizedBox(height: 30.0,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.0),
                  child: Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: btnBackground),
                      onPressed: !isRestButtonEnabled ? () {print('null');} : () async {
                        setState(() {
                          isConferenceButtonEnabled = false;
                          isRestButtonEnabled = false;
                          isReportButtonEnabled = false;
                        });
                        _counter += 1;
                        List floors = await getTableDetails('floors');
                        List rooms = await getTableDetails('rooms');
                        List resRooms = categoriseRooms(floors, rooms, 'REST ROOM');
                        print(resRooms);
                        Navigator.pushNamed(context, '/rest', arguments: {
                          'floors' : floors,
                          'rooms' : resRooms,
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Text('Rest Room Availability', style: btnStyle, overflow: TextOverflow.ellipsis,),
                      ),
                      // style: ButtonStyle(
                      //   backgroundColor: 
                      // ),
                    ),
                  ),
                ),
                SizedBox(height: 30.0,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.0),
                  child: Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: btnBackground),
                      onPressed: !isReportButtonEnabled ? () {print('null');} : () async {
                        setState(() {
                          isConferenceButtonEnabled = false;
                          isRestButtonEnabled = false;
                          isReportButtonEnabled = false;
                        });
                        _counter += 1;
                        print('report');
                        await canLaunch(_surveyUrl) ? launch(_surveyUrl) : print('not launched');
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Text('Report an Issue', style: btnStyle, overflow: TextOverflow.ellipsis,),
                      ),
                      // style: ButtonStyle(
                      //   backgroundColor: 
                      // ),
                    ),
                  ),
                ),
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