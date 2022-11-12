import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quick_shift/screens/auth_page.dart';
import 'package:quick_shift/screens/home_page.dart';
import 'package:quick_shift/screens/mobile_body.dart';
import 'package:quick_shift/screens/desktop_body.dart';

class CheckLoginStatus extends StatelessWidget {
  const CheckLoginStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //return const HomePage();
            return const DesktopScaffold();
            // return const MobileScaffold();
          } else {
            return const AuthPage();
          }
        },
      ),
    );
  }
}
