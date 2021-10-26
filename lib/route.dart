import 'package:flutter/material.dart';
import 'package:voice_doctor/home.dart';
import 'package:voice_doctor/sms.dart';
import 'package:voice_doctor/verify.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  '/': (BuildContext context) => new SmsPage(title: 'title',),
  '/verify': (BuildContext context) => new VerifyPage(keyText: Key("title")),
  '/home': (BuildContext context) => new HomePage(),
};