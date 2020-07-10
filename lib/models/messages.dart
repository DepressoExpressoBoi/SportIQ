

class Message {

  final String uid;

  Message({this.uid});
}

class MessageData {
  final String uid;
  final String user1;
  final String user2;
  final String groupChatId;

  MessageData({ this.uid, this.user1, this.user2, this.groupChatId});
}