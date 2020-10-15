import 'package:flash_chat/components/roundbutton.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const id = "welcome_screen";
  @override
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: "logo",
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                Text(
                  'RENTY',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            new RoundButton(
              buttoncolor: Colors.lightBlueAccent,
              buttontext: 'Log In',
              buttonfunction: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundButton(buttoncolor: Colors.blueAccent ,
            buttontext: 'Register' ,
            buttonfunction:  () {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },)
           
          ],
        ),
      ),
    );
  }
}
