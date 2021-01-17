import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jsonplaceholder_app/helpers/colors_helper.dart';

class CustomToast {
  final String message;
  Toast length;

  CustomToast(this.message, {length = Toast.LENGTH_SHORT}) {
    show(message);
  }

  void show(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: length,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: ColorsHelper.toastBackground,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}