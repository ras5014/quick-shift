import 'package:flutter/material.dart';
import 'package:quick_shift/constants.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({super.key});

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
      backgroundColor: defaultBackgroundColor,
      body: Row(
        children: [
          myDrawer,
        ],
      ),
    );
  }
}
