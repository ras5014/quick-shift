// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers, unused_element, unused_local_variable, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:quick_shift/constants.dart';
import 'package:quick_shift/screens/DashboardPages/user_scaffold.dart';

class UserBooking extends StatefulWidget {
  UserBooking({super.key});

  @override
  State<UserBooking> createState() => _UserBookingState();
}

class _UserBookingState extends State<UserBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
      backgroundColor: defaultBackgroundColor,
      drawer: Drawer(
        backgroundColor: Colors.grey[300],
        child: Column(children: [
          DrawerHeader(
            child: ImageIcon(AssetImage('assets/images/logo.png'), size: 160),
          ),
          //child: ImageIcon(AssetImage('assets/images/logo.png'), size: 160)),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: Icon(Icons.home),
              title: Text(
                'D A S H B O A R D',
                style: drawerTextColor,
              ),
              onTap: (() {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return UserScaffold();
                }));
              }),
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: Icon(Icons.account_box),
              title: Text(
                'M Y  B O O K I N G S',
                style: drawerTextColor,
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return UserBooking();
                }));
              },
            ),
          ),
          Padding(
            padding: tilePadding,
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                'L O G O U T',
                style: drawerTextColor,
              ),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Phoenix.rebirth(context);
              },
            ),
          )
        ]),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('request')
              .where('userEmail', isEqualTo: user!.email)
              .orderBy('date', descending: true)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView(
              children: snapshot.data!.docs.map((snap) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black54,
                          blurRadius: 10.0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[900],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.date_range,
                                color: Colors.deepPurple,
                              ),
                              SizedBox(width: 5),
                              Text(
                                snap['date'].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      ImageIcon(
                                        AssetImage("assets/images/source.png"),
                                        color: Colors.deepPurple,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        snap['sourceAddress'].toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      ImageIcon(
                                        AssetImage(
                                            "assets/images/destination.png"),
                                        color: Colors.deepPurple,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        snap['destinationAddress'].toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 30),
                            Column(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(children: [
                                      ImageIcon(
                                        AssetImage("assets/images/driver.png"),
                                        color: Colors.deepPurple,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        snap['driverName'].toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ])),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      ImageIcon(
                                        AssetImage(
                                            "assets/images/driverPhone.png"),
                                        color: Colors.deepPurple,
                                      ),
                                      SizedBox(width: 5),
                                      GestureDetector(
                                        onTap: () async {
                                          await FlutterPhoneDirectCaller
                                              .callNumber(snap['driverPhoneNo']
                                                  .toString());
                                        },
                                        child: Text(
                                          snap['driverPhoneNo'].toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: 57,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.deepPurple,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Status: " + snap['status'].toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    //backgroundColor: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 30),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey[900],
                                  ),
                                  onPressed: () {
                                    if (snap['status'].toString() ==
                                        "Processing") {
                                      FirebaseFirestore.instance
                                          .collection('request')
                                          .doc(snap.reference.id)
                                          .delete();
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                              content: Text(
                                            "Your Request has been accepted, Please contact us to cancel",
                                            textAlign: TextAlign.center,
                                          ));
                                        },
                                      );
                                    }
                                  },
                                  child: Text(
                                    "Cancel SHIFT",
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
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
              }).toList(),
            );
          }),
    );
  }
}
