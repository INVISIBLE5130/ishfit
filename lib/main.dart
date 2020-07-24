import 'package:first_flutter_app/screens/landing.dart';
import 'package:first_flutter_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'domain/user.dart';

void main() => runApp(FirstFlutterApp());

class FirstFlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().currentUser,
      child: MaterialApp(
        title: 'IshFit',
        theme: ThemeData(
            primaryColor: Colors.blueGrey,
            textTheme: TextTheme(title: TextStyle(color: Colors.white))
        ),
        home: LandingPage()
      )
    );
  }
}