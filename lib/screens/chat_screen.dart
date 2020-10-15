import 'package:flash_chat/main.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bubble/bubble.dart';
import 'package:http/http.dart';

class ChatScreen extends StatefulWidget {
  static const id = "chat_screen";
  String masseges;
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _store = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  final messagetextcontroler = TextEditingController();
  FirebaseUser loggedInUser;
  String masseges;
  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  void getstream() async {
    await for (var snapshot in _store.collection("messages").snapshots()) {
      for (var masseges in snapshot.documents) {
        print(masseges.data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                {
                  setState(() {
                    FlashChat.homescreen = WelcomeScreen.id;
                  });

                  _auth.signOut();
                  Navigator.pop(context);
                }
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder(
              stream: _store
                  .collection("messages")
                  .orderBy("time", descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent),
                  );
                }

                final messages = snapshot.data.documents.reversed;
                List<Widget> chatlist = [];
                for (var message in messages) {
                  final messagetext = message.data["text"];
                  final messagesender = message.data["sender"];
                  final messagetime = message.data["time"];

                  final alignment = messagesender == loggedInUser.email
                      ? TextAlign.end
                      : TextAlign.start;
                  final bubble = Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    child: Bubble(
                      margin: BubbleEdges.only(top: 10.0),
                      child: Row(
                        mainAxisAlignment: messagesender == loggedInUser.email
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                "$messagesender",
                                textAlign: alignment,
                              ),
                              SizedBox(
                                height: 7.50,
                              ),
                              Text(
                                "$messagetext",
                                textAlign: alignment,
                              ),
                              SizedBox(
                                height: 7.50,
                              ),
                              Text(
                                "$messagetime",
                                textAlign: alignment,
                              ),
                            ],
                          )
                        ],
                      ),
                      nip: messagesender == loggedInUser.email
                          ? BubbleNip.rightBottom
                          : BubbleNip.leftBottom,
                      color: messagesender == loggedInUser.email
                          ? Colors.white
                          : Colors.lightBlueAccent,
                    ),
                  );
                  chatlist.add(bubble);
                }
                return Expanded(
                    child: ListView(
                  reverse: true,
                  children: chatlist,
                ));
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messagetextcontroler,
                      onChanged: (value) {
                        masseges = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messagetextcontroler.clear();
                      _store.collection("messages").add({
                        "text": masseges,
                        "sender": loggedInUser.email,
                        "time": Timestamp.now()
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
