import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";

  final data;
  HomeScreen({this.data});

  @override
  _HomeScreenState createState() => _HomeScreenState(data);
}

class _HomeScreenState extends State<HomeScreen> {
  final data;

  _HomeScreenState(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data ?? "Welcome to Ooty, Nice to meet you!"),
      ),
    );
  }
}
