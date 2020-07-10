import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:SportIQ/models/sports.dart';
import 'package:SportIQ/models/user.dart';

class DatabaseService {

  final String uid;
  DatabaseService({this.uid});

  //Reference Collection
  final CollectionReference usersCollection = Firestore.instance.collection('users');
  final CollectionReference messageCollection = Firestore.instance.collection('messages');

  Future updateUserData(String uid, String sport, String name, String team, String debatesWon, String tournamentsWon, int registered, String image, String topicChoice, String sportDebateChoice, String debateSide, int judge, String idTo, String idFrom) async {
    return await usersCollection.document(uid).setData({
      'uid': uid,
      'sport': sport,
      'name': name,
      'team': team,
      'debatesWon': debatesWon,
      'tournamentsWon': tournamentsWon,
      'registered': registered,
      'image': image,
      'topicChoice': topicChoice,
      'sportDebateChoice': sportDebateChoice,
      'debateSide': debateSide,
      'judge': judge,
      'idTo': idTo,
      'idFrom': idFrom,
    });
  }

  List<Users> _usersListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return Users(
        uid: doc.data['uid'] ?? '',
        sport: doc.data['sport'] ?? '',
        name: doc.data['name'] ?? '',
        team: doc.data['team'] ?? '',
        debatesWon: doc.data['debatesWon'] ?? '',
        tournamentsWon: doc.data['tournamentsWon'] ?? '',
        image: doc.data['image'] ?? '',
        topicChoice: doc.data['topicChoice'] ?? '',
        sportDebateChoice: doc.data['sportDebateChoice'] ?? '',
        debateSide: doc.data['debateSide'] ?? '',
        judge: doc.data['judge'] ?? 0,
        idTo: doc.data['idTo'] ?? '',
        idFrom: doc.data['idFrom'] ?? '',
      );
    }).toList();
  }


  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: snapshot.data['uid'],
      sport: snapshot.data['sport'],
      name: snapshot.data['name'],
      team: snapshot.data['team'],
      debatesWon: snapshot.data['debatesWon'],
      tournamentsWon: snapshot.data['tournamentsWon'],
      registered: snapshot.data['registered'],
      image: snapshot.data['image'],
      topicChoice: snapshot.data['topicChoice'],
      sportDebateChoice: snapshot.data['sportDebateChoice'],
      debateSide: snapshot.data['debateSide'],
      judge: snapshot.data['judge'],
      idTo: snapshot.data['idTo'],
      idFrom: snapshot.data['idFrom'],
    );
  }

  Stream<List<Users>> get users {
    return usersCollection.snapshots()
    .map(_usersListFromSnapshot);
  }

  Stream<UserData> get userData {
    return usersCollection.document(uid).snapshots()
    .map(_userDataFromSnapshot);
  }


  // List<Message> _messagesFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.documents.map((doc){
  //     return Message(
  //       uid: doc.data['uid'] ?? '',
  //       user1: ,
 
  //     );
  //   }).toList();
  // }


  // UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
  //   return UserData(
  //     uid: snapshot.data['uid'],
  //     sport: snapshot.data['sport'],
  //     name: snapshot.data['name'],
  //     team: snapshot.data['team'],
  //     debatesWon: snapshot.data['debatesWon'],
  //     tournamentsWon: snapshot.data['tournamentsWon'],
  //     registered: snapshot.data['registered'],
  //     image: snapshot.data['image'],
  //     topicChoice: snapshot.data['topicChoice'],
  //     sportDebateChoice: snapshot.data['sportDebateChoice'],
  //     debateSide: snapshot.data['debateSide'],
  //     judge: snapshot.data['judge']
  //   );
  // }

  // Stream<List<Users>> get users {
  //   return usersCollection.snapshots()
  //   .map(_usersListFromSnapshot);
  // }

  // Stream<UserData> get userData {
  //   return usersCollection.document(uid).snapshots()
  //   .map(_userDataFromSnapshot);
  // }

}