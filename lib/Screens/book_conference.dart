import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:iot_app_2/network/server_communication.dart';
import 'package:timezone/timezone.dart';
import 'common_methods.dart';

class Book extends StatefulWidget {
  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> {

  String pickedDate;
  String fromTime;
  String toTime;
  List users = [];
  TextEditingController description = TextEditingController();
  TextEditingController addToUserController = TextEditingController();
  Map<int, TextEditingController> tecs = {};
  var tf = <TextField>[];
  List<TextEditingController> emailController = [];
  // List<Widget> _children = [];
  int count = 0;

  String convertTimeOfDay(TimeOfDay tod) {
    final now = DateTime.now();
    final format = DateFormat('hh:mm a').format(DateTime(now.year, now.minute, now.second, tod.hour, tod.minute));
    return format;
  }

  @override
  void dispose() {
    emailController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Map data = ModalRoute.of(context).settings.arguments;
    String roomId = data['room_id'].toString();
    int roomMaxCount = data['room_count'];
    String user = data['user'];
    String rno = data['rno'];
    emailController.clear();
    addToUserController.clear();

    return Scaffold(
      // backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(height: 60.0,),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Text('Book Room | #$rno',
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
                  // Container(child: SizedBox(width: 20.0,),),
                  Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: SizedBox(width: 30.0,),
                  )
                ],
              ),
              Container(
                height: 670.0,
                // color: Colors.grey,
                child: Column(
                  children: [
                    SizedBox(height: 20.0,),
                    GestureDetector(
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 120),),
                        ).then((value) {
                          print(value);
                          String formatterDateTime = DateFormat('dd LLL yyyy').format(value).toString();
                          print(formatterDateTime);
                          setState(() {
                            pickedDate = formatterDateTime;
                          });
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
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
                        ).then((value) {
                          setState(() {
                            fromTime = convertTimeOfDay(value);
                          });
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
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
                        ).then((value) {
                          setState(() {
                            toTime = convertTimeOfDay(value);
                          });
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
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
                    Container(
                      padding: EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
                      child: TextField(
                        controller: description,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        maxLength: 100,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                          fillColor: Theme.of(context).primaryColor,
                          filled: true,
                          labelText: 'Description',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          prefixIcon: Icon(Icons.description, size: 30.0, color: Colors.white,),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20.0, top: 5.0, right: 20.0),
                      child: TextField(
                        controller: addToUserController,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                          fillColor: Theme.of(context).primaryColor,
                          filled: true,
                          labelText: 'Person Name (optional)',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                          prefixIcon: Icon(Icons.face_rounded, size: 30.0, color: Colors.white,),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              // addToUserController.clear();
                              // if (users.length < 14) {
                              //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              //     backgroundColor: Colors.grey,
                              //     content: Text('Room is full can\'t add more person'),
                              //   ));
                              // }
                              if (addToUserController.text != '' && users.length < 14) {
                                setState(() {
                                  users.add(addToUserController.text);
                                  // addToUserController.text = '';
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  backgroundColor: Colors.grey,
                                  content: Text('To add a person enter the name or try to remove from the list'),
                                ));
                              }
                            },
                            child: Icon(Icons.add_circle_sharp, size: 30.0, color: Colors.green,)
                          ),
                          // suffix: Text('add'),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                        // color: Colors.blueGrey,
                        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        child: ListView.builder(
                          itemCount: users.length,
                          // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                children: [
                                  Text('${index + 1}.  ${users[index]}',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        users.removeAt(index);
                                      });
                                    },
                                    icon: Icon(Icons.remove_circle, color: Colors.red, size: 30.0,)
                                  )
                                  // Text('REMOVE',
                                  //   style: TextStyle(
                                  //     color: Colors.red,

                                  //   ),
                                  // ),
                                ],
                              )
                            );
                          },
                        ),
                      ),
                    )
                    // Expanded(
                    //   child: Container(
                    //     color: Colors.grey,
                    //     margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),

                    //   ),
                    // )
                    // Expanded(
                    //   child: Container(
                    //     // margin: EdgeInsets.symmetric(horizontal: 20.0),
                    //     // padding: EdgeInsets.symmetric(horizontal: 20.0),
                    //     // color: Colors.pink,
                    //     child: ListView.builder(
                    //       itemCount: roomMaxCount - 1,
                    //       itemBuilder: (context, index) {
                    //         TextEditingController controller = TextEditingController();
                    //         emailController.add(controller);
                    //         return Container(
                    //           margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                    //           child: TextField(
                    //             controller: controller,
                    //             style: TextStyle(
                    //               color: Colors.white,
                    //             ),
                    //             keyboardType: TextInputType.emailAddress,
                    //             decoration: InputDecoration(
                    //               // contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                    //               fillColor: Theme.of(context).primaryColor,
                    //               filled: true,
                    //               // prefix: Text(),
                    //               prefixText: '${index + 1}. ',
                    //               prefixStyle: TextStyle(
                    //                   color: Colors.white,
                    //                 ),
                    //               labelText: 'Person\'s email id (optional)',
                    //               labelStyle: TextStyle(
                    //                 color: Colors.white,
                    //               )
                    //             ),
                    //           ),
                    //         );
                    //       },
                    //     )
                    //   ),
                    // )
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: GestureDetector(
                    onTap: () async {
                      DateTime ftime = DateFormat('hh:mm a').parse(fromTime);
                      DateTime ttime = DateFormat('hh:mm a').parse(toTime);
                      DateTime fdt = DateFormat('dd LLL yyyy').parse(pickedDate).add(Duration(hours: ftime.hour, minutes: ftime.minute));
                      DateTime tdt = DateFormat('dd LLL yyyy').parse(pickedDate).add(Duration(hours: ttime.hour, minutes: ttime.minute));
                      String fromDateTime = fdt.toString().substring(0, 10) + "T" + fdt.toString().substring(11, 19) + "Z";
                      String toDatetime = tdt.toString().substring(0, 10) + "T" + tdt.toString().substring(11, 19) + "Z";

                      print(fromDateTime);
                      print(toDatetime);
                      print(description.text);
                      print(roomId);
                      print(user);
                      List bookings = await getTableDetails('bookings');
                      List filteredRooms = filterRooms(bookings, int.parse(roomId));
                                              
                      bool success = await postBooking(fromDateTime, toDatetime, description.text, roomId, user);
                      if (success) {
                        //navigate to conference room screen with replacednavigator
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(context, '/booking', arguments: {
                          'room_details': filteredRooms,
                          'room_id': roomId,
                          'room_count': roomMaxCount,
                          'user': user,
                          'rno': rno,
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Enter valid details'),
                          backgroundColor: Colors.grey,
                        ));
                      }

                      // print(emailController.length);
                      // emailController.forEach((element) {
                      //   if (element.text != '' && element.text.contains('@') && element.text.contains('.')){
                      //     users.add(element.text);
                      //   }
                      // });
                      // print(users);
                    },
                    child: Container(
                      color: Theme.of(context).primaryColor,
                      // color: Colors.red,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            // color: Theme.of(context).primaryColor,
                            // color: Colors.red,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Container(
                                alignment: Alignment.center,
                                // color: Colors.white,
                                child: Text('Submit',
                                  style: TextStyle(
                                    color: Colors.white,
                                    // letterSpacing: 1.2,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                  ),
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