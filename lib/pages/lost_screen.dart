import 'package:flutter/material.dart';

class LostScreen extends StatelessWidget {
  static const String routeName = "/lost";
  final data;
  LostScreen({this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(data ?? "You're lost"),
      ),
    );
  }
}
