import 'package:first_flutter_app/screens/auth.dart';
import 'package:first_flutter_app/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(FirstFlutterApp());

class FirstFlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'IshFit',
        theme: ThemeData(
            primaryColor: Colors.blueGrey,
            textTheme: TextTheme(title: TextStyle(color: Colors.white))
        ),
        home: AuthorizationPage()
    );
  }
}