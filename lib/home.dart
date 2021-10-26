import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0.0,
        ),
        body: HomePageBody(),
        // ),
      ),
    );
  }
}

class HomePageBody extends StatelessWidget {
  HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Text("Home dayo"));
  }
}