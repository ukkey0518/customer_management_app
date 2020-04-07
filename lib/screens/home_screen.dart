import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/images/flutter_logo.png',
                height: 200,
                width: 200,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
