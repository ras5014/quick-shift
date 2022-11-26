// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyBox extends StatelessWidget {
  const MyBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.deepPurple,
        ),
        child: Center(
            child: Text(
          "Loading...",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        )),
      ),
    );
  }
}
