import 'package:flash_chat/components/inputfield.dart';
import 'package:flash_chat/components/roundbutton.dart';
import 'package:flash_chat/main.dart';
import 'package:flash_chat/screens/chat_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter/material.dart';
class RegistrationScreen extends StatefulWidget {
  static const id = "Registration_screen";
  @override
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool showspinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showspinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: "logo",
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              Inputfield(
                hint: 'Enter your email',
                onchange: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              SizedBox(
                height: 8.0,
              ),
              Inputfield(
                hint: 'Enter your password',
                onchange: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundButton(
                buttoncolor: Colors.blueAccent,
                buttontext: 'Register',
                buttonfunction: () async {
                  setState(() {
                    showspinner = true;
                  });
                  try {
                    final newuser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newuser != null)
                    setState(() {
                       FlashChat.homescreen = ChatScreen.id;
                    });
                     
                      Navigator.pushNamed(context, ChatScreen.id);
                  } catch (e) {
                    print(e);
                  }
                  setState(() {
                    showspinner = false;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
