// ignore_for_file: unrelated_type_equality_checks, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:quick_shift/data_getter.dart';

class DashboardLoader extends StatelessWidget {
  const DashboardLoader(
      {super.key, required this.userScaffold, required this.driverScaffold});

  final Widget userScaffold;
  final Widget driverScaffold;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getUser_type(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (type == 'User') {
              return userScaffold;
            } else {
              return driverScaffold;
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
