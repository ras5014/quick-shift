// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quick_shift/constants.dart';
import 'package:quick_shift/screens/DashboardPages/driver_scaffold.dart';
import 'package:quick_shift/screens/DashboardPages/user_scaffold.dart';

// Getting users Table Data

late String user_firstname = '', user_phoneNumber = '', user_lastname = '';

Future getUser_info() async {
  await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: user!.email)
      .get()
      .then((QuerySnapshot results) {
    user_firstname = results.docs[0]['firstname'];
    user_phoneNumber = results.docs[0]['phoneNumber'];
    user_lastname = results.docs[0]['lastname'];
  });
}

// Getting user type

late String type = '';
Future getUser_type() async {
  await FirebaseFirestore.instance
      .collection('userType')
      .where('email', isEqualTo: user!.email)
      .get()
      .then((results) {
    type = results.docs[0]['type'];
  });
}
