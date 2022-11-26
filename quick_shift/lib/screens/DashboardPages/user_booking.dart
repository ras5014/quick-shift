// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quick_shift/constants.dart';
import 'package:quick_shift/screens/DashboardPages/user_scaffold.dart';
import 'package:quick_shift/screens/dataLoader_box.dart';
import 'package:quick_shift/screens/signin_page.dart';

class UserBooking extends StatefulWidget {
  UserBooking({super.key});

  @override
  State<UserBooking> createState() => _UserBookingState();
}

class _UserBookingState extends State<UserBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text('WELCOME ${user!.email!}'),
        centerTitle: false,
      ),
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
              onTap: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SignInScreen(
                              showRegisterPage: () {},
                            )),
                  );
                });
              },
            ),
          )
        ]),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('request')
              .where('userEmail', isEqualTo: user!.email)
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
                    height: 217,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.deepPurple,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Shift Scheduled On: " + snap['date'].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Source: " + snap['sourceAddress'].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Destination: " +
                                snap['destinationAddress'].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Driver Name: " + snap['driverName'].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Driver Phone: " + snap['driverPhoneNo'].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 3,
                          color: Colors.black54,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Status: " + snap['status'].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              backgroundColor: Colors.black54,
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
