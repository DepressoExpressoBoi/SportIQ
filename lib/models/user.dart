

class User {

  final String uid;

  User({this.uid});
}

class UserData {
  final String uid;
  final String sport;
  final String team;
  final String name;
  final String debatesWon;
  final String tournamentsWon;
  final int registered;
  final String image;
  final String topicChoice;
  final String sportDebateChoice;
  final String debateSide;
  final int judge;
  final String idTo;
  final String idFrom;

  UserData({ this.uid, this.sport, this.name, this.team, this.debatesWon, this.tournamentsWon, this.registered, this.image, this.topicChoice, this.sportDebateChoice, this.debateSide, this.judge, this.idTo, this.idFrom});
}