import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:SportIQ/models/user.dart';
import 'package:SportIQ/services/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/cupertino.dart';


class Chat extends StatelessWidget {
  final String peerId;
  final String appName;
  final String peerName;

  Chat({Key key, @required this.peerId, @required this.appName, @required this.peerName}) : super(key: key);

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
      body: new ChatScreen(
        peerId: peerId,
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String peerId;

  ChatScreen({Key key, @required this.peerId}) : super(key: key);

  @override
  State createState() => new ChatScreenState(peerId: peerId);
}

class ChatScreenState extends State<ChatScreen> {
  ChatScreenState({Key key, @required this.peerId});

  String peerId;
  String id;
  String idName;
  int messagesSent = 0;

  File imageFile;
  String imageUrl = '';
  bool isLoading = false;

  var listMessage;
  String groupChatId;

  final Firestore _firestore = Firestore.instance;

  TextEditingController textEditingController = TextEditingController();
  ScrollController listScrollController = ScrollController();

  Future<bool> onBackPress() {
      Navigator.pop(context);

    return Future.value(false);
  }   

  Future<void> sendMessage(String content, int type) async {
    if (textEditingController.text.length > 0) {
      await _firestore.collection('messages').document(groupChatId).collection(groupChatId).add({
        'idFrom': id,
        'idFromName': idName, 
        'idTo': peerId,
        'timestamp': DateTime.now().toIso8601String().toString(),
        'content': content,
        'type': type,
      });

      messagesSent = messagesSent + 1;
      print(messagesSent);
      textEditingController.clear();
      listScrollController.animateTo(
        listScrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
      setState(() {
      });
      
    } else {
      print('Nothing to send');
    }
  }

  Future getImage() async {
    File selected = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (selected != null) {
      setState(() {
        isLoading = true;
        imageFile = selected;
      });
      uploadFile();
    }
  }

  Future uploadFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putFile(imageFile);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
      imageUrl = downloadUrl;
      setState(() {
        isLoading = false;
        sendMessage(imageUrl, 1);
      });
      sendMessage(imageUrl, 1);

    }, onError: (err) {
      setState(() {
        isLoading = false;
      });
    });

    sendMessage(imageUrl, 1);
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
      if (doc.data['type'] == 0) {
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
                    doc.data['content'],
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
      } else if(doc.data['type'] == 1) {
         Container(
          child: FlatButton(
            child: Material(
              child: CachedNetworkImage(
                placeholder: (context, url) => Container(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
                  ),
                  width: 200.0,
                  height: 200.0,
                  padding: EdgeInsets.all(70.0),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Material(
                  child: Image.asset(
                    'images/img_not_available.jpeg',
                    width: 200.0,
                    height: 200.0,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  clipBehavior: Clip.hardEdge,
                ),
                imageUrl: doc.data['content'],
                width: 200.0,
                height: 200.0,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              clipBehavior: Clip.hardEdge,
            ),
            onPressed: () {
            //   Navigator.push(
            //       context, MaterialPageRoute(builder: (context) => FullPhoto(url: doc.data['content'])));
            // },
            // padding: EdgeInsets.all(0),
          }
          )
        );
      }
    } else {
      if (doc.data['type'] == 0) {
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
                    doc.data['content'],
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
      } else if (doc.data['type'] == 1) {
        Container(
          child: FlatButton(
            child: Material(
              child: CachedNetworkImage(
                placeholder: (context, url) => Container(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
                  ),
                  width: 200.0,
                  height: 200.0,
                  padding: EdgeInsets.all(70.0),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Material(
                  child: Image.asset(
                    'images/img_not_available.jpeg',
                    width: 200.0,
                    height: 200.0,
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  clipBehavior: Clip.hardEdge,
                ),
                imageUrl: doc.data['content'],
                width: 200.0,
                height: 200.0,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              clipBehavior: Clip.hardEdge,
            ),
            onPressed: () {
            //   Navigator.push(
            //       context, MaterialPageRoute(builder: (context) => FullPhoto(url: doc.data['content'])));
            // },
            // padding: EdgeInsets.all(0),
          }
          )
        );
      } 
      
    }
    return Container(
    );
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
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 1.0),
                    child: IconButton(
                      icon: Icon(Icons.image),
                      onPressed: getImage,
                      color: Colors.white,
                    )
                  ),
                  Expanded(
                    child: TextField(
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
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    child: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () => sendMessage(textEditingController.text, 0),
                      color: Colors.white,
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


















