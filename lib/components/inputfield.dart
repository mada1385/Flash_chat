import 'package:flutter/material.dart';

class Inputfield extends StatelessWidget {
  final String hint;
  final Function onchange;

  const Inputfield({this.hint, this.onchange});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.black),
      onChanged: onchange,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        hintText: hint,
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
      ),
    );
  }
}
