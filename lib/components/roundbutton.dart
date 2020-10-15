import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String buttontext ;
  final Color buttoncolor ;
  final Function buttonfunction ;
  const RoundButton({
    this.buttonfunction,
    this.buttoncolor,
    this.buttontext,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: buttoncolor,
        // 
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: buttonfunction,
            // 
          
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            buttontext
            
          ),
        ),
      ),
    );
  }
}
