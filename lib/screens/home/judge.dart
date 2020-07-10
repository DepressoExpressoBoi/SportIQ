import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:SportIQ/models/user.dart';
import 'package:SportIQ/services/database.dart';

class Judge extends StatelessWidget {
  final String peerId;
  final String appName;
  final String peerName;

  Judge({Key key, @required this.peerId, @required this.appName, @required this.peerName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
      appBar: new AppBar(
        backgroundColor: Colors.black,
        title: new Text(
          appName + ' and ' + peerName + ' Debate',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: new JudgingScreen(
        peerId: peerId,
      ),
    );
  }
}

class JudgingScreen extends StatefulWidget {
  final String peerId;

  JudgingScreen({Key key, @required this.peerId}) : super(key: key);

  @override
  State createState() => new JudgingScreenState(peerId: peerId);
}

class JudgingScreenState extends State<JudgingScreen> {
  JudgingScreenState({Key key, @required this.peerId});

  String peerId;
  String id;
  String idName;

  var listMessage;
  String groupChatId;

  final Firestore _firestore = Firestore.instance;

  TextEditingController textEditingController = TextEditingController();
  ScrollController listScrollController = ScrollController();

  Future<bool> onBackPress() {
      Navigator.pop(context);

    return Future.value(false);
  }   

  Future<void> callback() async {
    if (textEditingController.text.length > 0) {      
      await _firestore.collection('messages').document(groupChatId).collection(groupChatId).add({
        'idFrom': id,
        'idFromName': idName, 
        'idTo': peerId,
        'timestamp': DateTime.now().toIso8601String().toString(),
        'text': textEditingController.text,
      });

      textEditingController.clear();
      listScrollController.animateTo(
        listScrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );

    } else {
      print('Nothing to send');
    }
  }

   @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData> (
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        UserData userData = snapshot.data;

        readLocal() async {
          if(id.hashCode <= peerId.hashCode) {
            groupChatId = '$id-$peerId';
          } else {
            groupChatId = '$peerId-$id';
          }
        }

  readLocal();
  id = user.uid;
  idName = userData.name;

  Widget buildList(BuildContext context, DocumentSnapshot doc) {
    if (doc.data['idFrom'] == id) {
      return Container(
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.end,
        children: <Widget>[
          Material(
            color: Colors.cyan[300],
            borderRadius: BorderRadius.circular(10.0),
            elevation: 6.0,
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Text(
                doc.data['text'],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
          Container(
            height: 5.0,
          )
        ],
      ),
    );
    } else {
      return Container(
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: <Widget>[
          Material(
            color: Colors.cyan[700],
            borderRadius: BorderRadius.circular(10.0),
            elevation: 6.0,
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Text(
                doc.data['text'],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
          Container(
            height: 5.0,
          )
        ],
      ),
    );
    }
  }

    return WillPopScope(
      onWillPop: onBackPress,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('messages')
                    .document(groupChatId)
                    .collection(groupChatId)
                    .orderBy('timestamp')
                    .snapshots(),
                builder: (context, snapshot) {

                  if (snapshot.data != null) {
                    listMessage = snapshot.data.documents;

                    return ListView.builder(
                      itemCount: listMessage.length,
                      controller: listScrollController,
                      itemBuilder: (context, index) {
                          return buildList(context, snapshot.data.documents[index]);
                      }
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onSubmitted: (value) => callback(),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: "Enter a Message...",
                        enabledBorder: new UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: new UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        border: const OutlineInputBorder(),
                        hintStyle: TextStyle(color: Colors.white)
                      ),
                      controller: textEditingController,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SendButton(
                    text: "Send",
                    callback: callback,
                  )
                
                ],
              ),
            ),
                
          ],
        ),
      ),
    );
      }
    );

    
  }     
}

class SendButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;

  const SendButton({Key key, this.text, this.callback}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.cyan[300],
      onPressed: callback,
      child: Text(text),
    );
  }
}

















