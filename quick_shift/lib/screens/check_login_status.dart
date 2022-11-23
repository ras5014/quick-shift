import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quick_shift/screens/auth_page.dart';
import 'package:quick_shift/screens/responsive/desktop_scaffold.dart';
import 'package:quick_shift/screens/responsive/mobile_scaffold.dart';
import 'package:quick_shift/screens/responsive/responsive_layout.dart';
import 'package:quick_shift/screens/responsive/tablet_scaffold.dart';

class CheckLoginStatus extends StatelessWidget {
  const CheckLoginStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const ResponsiveLayout(
              mobileScaffold: MobileScaffold(),
              tabletScaffold: TabletScaffold(),
              desktopScaffold: DesktopScaffold(),
            );
          } else {
            return const AuthPage();
          }
        },
      ),
    );
  }
}
