import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  String messageText;

  /// Method for checking if the current user is log in
  void getCurrentUser() async {
    /// mull if nobody is sign in
    final user = await _auth.currentUser();
    try {
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }
/// This method prints a list of string the list contains the messages that have
/// been sent. 
/// The user has to be the one who is actively presing a button to see if they
/// got new messages. OR, a timer has to be coded to make the method check every
/// couple of seconds.
/// The donw side to this method is that it gets a list of messages and if a new
/// one is sent it has to get the full list again and not just the new message.
/// This is why this method is not a STREAM<String>
  // void getMessages() async {
  //   final messages = await _firestore.collection('messages').getDocuments();
  //   for (var message in messages.documents) {
  //     print(message.data);
  //   }
  // }


/// This method does the samething as getMessages() the only difference is that 
/// it's actively waiting for new pieces of String data to come in. So it 
/// add's it to the current list
/// This is a Stream<String>
void messagesStream() async {
  await for(var snapshot in _firestore.collection('messages').snapshots()){
        for(var message in snapshot.documents){
          print(message.data);
        }
  }
}
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          /// Sign out button
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                messagesStream();
                // getMessages();
                // _auth.signOut();
                // Navigator.pop(context);
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
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      /// User entered message
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),

                  /// Send Button
                  FlatButton(
                    onPressed: () {
                      _firestore.collection('messages').add({
                        'text': messageText,
                        'sender': loggedInUser.email,
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
