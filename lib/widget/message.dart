import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String message;

  Message({this.message});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(message,
            style: TextStyle(
                color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
