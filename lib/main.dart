import 'package:flutter/material.dart';
import 'package:voice_doctor/auth.dart';
import 'package:voice_doctor/route.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserModel>(
      create: (_) => UserModel(),
      child: MaterialApp(
        routes: routes,
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: TextTheme(
            bodyText1: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(26, 25, 60, 1.0),
            ),
          ),
        ),
        // home: MainPage(),
        initialRoute: '/',
      ),
    );
  }
}