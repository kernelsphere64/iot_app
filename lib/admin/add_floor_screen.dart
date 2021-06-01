import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iot_app_2/network/server.dart';

class AddFloor extends StatefulWidget {
  @override
  _AddFloorState createState() => _AddFloorState();
}

class _AddFloorState extends State<AddFloor> {

  // int fno;
  final floor = TextEditingController();
  final enterFloorSB = SnackBar(
    content: Text('Enter valid Floor Number or Go back.',
      overflow: TextOverflow.ellipsis,
      // style: TextStyle(

      // ),
    ),
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
                            child: Text('Add Floor',
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
                            controller: floor,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: 'Floor No.',
                              // border: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(15.0),
                              //   borderSide: BorderSide(
                              //     width: ,
                              //   )
                              // ),
                              // enabledBorder: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(15.0),
                              // ),
                              // focusedBorder: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(15.0),
                              // )
                              // prefixIcon: Icon(Icons.account_box_rounded, size: 30.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Align(
                    alignment: FractionalOffset.bottomCenter,
                      child: GestureDetector(
                        onTap: () async {
                          if (floor.text == '' || floor.text == '0') {
                            ScaffoldMessenger.of(context).showSnackBar(enterFloorSB);
                          } else {
                            print("add floor");
                            print(floor.text);
                            putFloor(floor.text);
                            List floors = await getTableDetails('floors');
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(context, '/admin', arguments: {
                              'floors': floors,
                            });
                          }
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