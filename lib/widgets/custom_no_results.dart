import 'package:flutter/material.dart';

class CustomNoResults extends StatelessWidget {

  final String text;
  CustomNoResults({this.text = "No information available"});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(text),
      ),
    );
  }
}
