import 'package:flash_chat/components/inputfield.dart';
import 'package:flash_chat/components/roundbutton.dart';
import 'package:flash_chat/main.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const id = "id_screen";
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email, password;
  bool showspinner = false ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showspinner ,
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
              new Inputfield(
                hint: "Enter your email",
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
                hint: 'Enter your password.',
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
                buttoncolor: Colors.lightBlueAccent,
                buttontext: 'Log In',
                buttonfunction: () async {
                  setState(() {
                    showspinner = true;
                  });
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                        if (user != null)
                        {setState(() {
                       FlashChat.homescreen = ChatScreen.id;
                    });
                          Navigator.pushNamed(context, ChatScreen.id);
                        }
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
