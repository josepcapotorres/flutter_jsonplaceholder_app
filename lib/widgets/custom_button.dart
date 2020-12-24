import 'package:flutter/material.dart';
import 'package:jsonplaceholder_app/helpers/colors_helper.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  CustomButton({@required this.text, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: RaisedButton(
        color: ColorsHelper.buttonBackgroundColor,
        child: Text(
          text.toUpperCase(), 
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: onPressed,
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(8.0),
                  side: BorderSide(color: ColorsHelper.buttonBackgroundColor))
      ),
    );
  }
}
