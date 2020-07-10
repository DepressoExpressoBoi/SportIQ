import 'package:SportIQ/screens/home/judgescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:SportIQ/models/sports.dart';
import 'package:SportIQ/models/user.dart';
import 'package:SportIQ/screens/home/profilescreen.dart';
import 'package:SportIQ/screens/home/tournamentscreen.dart';
import 'package:SportIQ/services/database.dart';

import 'chatlist.dart';

class DebateScreen extends StatefulWidget {
  @override
  _DebateScreen createState() => _DebateScreen();
}

class _DebateScreen extends State<DebateScreen> {
  int _currentIndex = 0;
  int screen = 0;
  String topic1 = '';
  String topic2 = '';
  String topic3 = '';
  String topic4 = '';
  String topic5 = '';
  String side = '';
  String topicChoice = '';

  @override 
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (_currentIndex == 1) {
      return TournamentScreen();
    } else if(_currentIndex == 2) {
      return JudgeScreen();
    } else if(_currentIndex == 3) {
      return ProfileScreen();
    }

    return StreamBuilder<UserData> (
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        UserData userData = snapshot.data;
          
          void _showResponsePanel() {
          showModalBottomSheet(context: context, builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: Row(
                children: <Widget>[
                  Container(
                    height: 50.0,
                    width: 200.0,
                    child: TextField(
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)
                        ),
                        hintText: 'Enter Side of Debate',
                        hintStyle: TextStyle(color: Colors.black),
                      ),
                      style: TextStyle(color: Colors.black),
                      onChanged: (val) async {
                        setState(() {
                          side = val;
                        });
                      }
                    ),
                  ),
                  RaisedButton(
                    child: Text(
                      'Select',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0
                      ),
                    ),
                    onPressed: () async {
                      await DatabaseService(uid: user.uid).updateUserData(
                          userData.uid ?? userData.uid,
                          userData.sport ?? userData.sport, 
                          userData.name ?? userData.name, 
                          userData.sport ?? userData.team, 
                          userData.debatesWon ?? userData.debatesWon, 
                          userData.tournamentsWon ?? userData.tournamentsWon,
                          1 ?? userData.registered,
                          userData.image ?? userData.image,
                          topicChoice ?? userData.topicChoice,
                          userData.sportDebateChoice ?? userData.sportDebateChoice,
                          side ?? userData.debateSide,
                          userData.judge ?? userData.judge,
                          userData.idTo ?? userData.idTo,
                          userData.idFrom ?? userData.idFrom,
                        ); 
                      Navigator.pop(context);
                  })
                ],
              ),
            );
          });
        }


        void _showQuestionPanel() {
        showModalBottomSheet(context: context, builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Choose a Topic:',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.0,                  
                  ),
                ),
                SizedBox(height:30.0),
                OutlineButton(
                  child: Text(
                    topic1,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                  splashColor: Colors.cyan[300],
                  onPressed: () {
                    setState(() {
                      topicChoice = topic1;
                    });
                  }
                ),
                SizedBox(height:20.0),
                OutlineButton(
                  child: Text(
                    topic2,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                  splashColor: Colors.cyan[300],
                  onPressed: () {
                    setState(() {
                      topicChoice = topic2;
                    });
                  }
                ),
                SizedBox(height:20.0),
                OutlineButton(
                  child: Text(
                    topic3,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                  splashColor: Colors.cyan[300],
                  onPressed: () {
                    setState(() {
                      topicChoice = topic3;
                    });
                  }
                ),
                SizedBox(height:20.0),
                OutlineButton(
                  child: Text(
                    topic4,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                  splashColor: Colors.cyan[300],
                  onPressed: () {
                    setState(() {
                      topicChoice = topic4;
                    });
                  }
                ),
                SizedBox(height:20.0),
                OutlineButton(
                  child: Text(
                    topic5,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                    ),
                  ),
                  splashColor: Colors.cyan[300],
                  onPressed: () {
                    setState(() {
                      topicChoice = topic5;
                    });
                  }
                ),
                RaisedButton(
                    child: Text(
                      'Select',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0
                      ),
                    ),
                    onPressed: () async {
                      await DatabaseService(uid: user.uid).updateUserData(
                          userData.uid ?? userData.uid,
                          userData.sport ?? userData.sport, 
                          userData.name ?? userData.name, 
                          userData.sport ?? userData.team, 
                          userData.debatesWon ?? userData.debatesWon, 
                          userData.tournamentsWon ?? userData.tournamentsWon,
                          1 ?? userData.registered,
                          userData.image ?? userData.image,
                          topicChoice ?? userData.topicChoice,
                          userData.sportDebateChoice ?? userData.sportDebateChoice,
                          side ?? userData.debateSide,
                          userData.judge ?? userData.judge,
                          userData.idTo ?? userData.idTo,
                          userData.idFrom ?? userData.idFrom,
                        ); 
                      Navigator.pop(context);
                      _showResponsePanel(); 
                  })
              ],
            ), 
          );
        });
      }
      
    return StreamProvider<List<Users>>.value(
      value: DatabaseService().users,
      
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0.0,
            title: Center(child: Text(
              'Enter Tournament',
                style: TextStyle(
                  fontSize: 40,
                  color: Color(0xfffffafa),
                ),
              ),
            ),
          ),
          body: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: <Widget>[
                          SizedBox(height:5.0),
                            Column( 
                              children: <Widget>[
                                Center(
                                    child: Text(
                                      'Choose a Sport:',
                                      style: TextStyle(
                                      fontSize: 30,
                                      color: Color(0xfffffafa),
                                    ),
                                  )
                                ),
                                Center(
                                  child: Row( 
                                    children: <Widget>[
                                      Padding(padding: EdgeInsets.symmetric(horizontal: 40.0)),
                                      SizedBox(height:20.0),
                                      Container(
                                        height: 100.0,
                                        width: 100.0,
                                        decoration: BoxDecoration(
                                          image: DecorationImage( 
                                            image: AssetImage('assets/images/37BCA2DC-DD6D-402A-A0D3-2045F09F58D4.png'),
                                          )
                                        ),
                                        child: FlatButton(
                                          padding: EdgeInsets.all(0.0),
                                          splashColor: Colors.cyan[300],
                                          onPressed: () async {
                                            await DatabaseService(uid: user.uid).updateUserData(
                                              userData.uid ?? userData.uid,
                                              userData.sport ?? userData.sport, 
                                              userData.name ?? userData.name, 
                                              userData.sport ?? userData.team, 
                                              userData.debatesWon ?? userData.debatesWon, 
                                              userData.tournamentsWon ?? userData.tournamentsWon,
                                              1 ?? userData.registered,
                                              userData.image ?? userData.image,
                                              topic5 ?? userData.topicChoice,
                                              'basketball' ?? userData.sportDebateChoice,
                                              userData.debateSide ?? userData.debateSide,
                                              userData.judge ?? userData.judge,
                                              userData.idTo ?? userData.idTo,
                                              userData.idFrom ?? userData.idFrom,
                                            ); 
                                            setState(() {
                                            topic1 = '''Who was more important to MJs success Phil Jackson or Scottie Pippen?''';
                                            topic2 = '''Whos the GOAT, MJ or Lebron?''';
                                            topic3 = '''Would you rather build your franchise around Trae Young or Luka Doncic?''';
                                            topic4 = '''Whos the better Center, Hakeem or Kareem?''';
                                            topic5 = '''Is Steve Nash a top 5 point guard of all time(yes or no)?''';
                                            _showQuestionPanel();
                                          });
                                        }, child: null,
                                      ),
                                    ),
                                    Container(
                                      width: 30.0,
                                    ), 
                                    Container(
                                      height: 100.0,
                                      width: 100.0,
                                      decoration: BoxDecoration(
                                        image: DecorationImage( 
                                          image: AssetImage('assets/images/8472C55F-7AD6-43CF-909A-FFEF3BCCD58F.png'),
                                        )
                                      ),
                                      child: FlatButton(
                                          padding: EdgeInsets.all(0.0),
                                          splashColor: Colors.cyan[300],
                                          onPressed: () async {
                                            await DatabaseService(uid: user.uid).updateUserData(
                                              userData.sport ?? userData.sport, 
                                              userData.uid ?? userData.uid,
                                              userData.name ?? userData.name, 
                                              userData.sport ?? userData.team, 
                                              userData.debatesWon ?? userData.debatesWon, 
                                              userData.tournamentsWon ?? userData.tournamentsWon,
                                              1 ?? userData.registered,
                                              userData.image ?? userData.image,
                                              topic5 ?? userData.topicChoice,
                                              'football' ?? userData.sportDebateChoice,
                                              userData.debateSide ?? userData.debateSide,
                                              userData.judge ?? userData.judge,
                                              userData.idTo ?? userData.idTo,
                                              userData.idFrom ?? userData.idFrom,
                                            ); 
                                            setState(() {
                                            topic1 = '''Does Tom Brady make the Buccaneers a playoff team?''';
                                            topic2 = '''Which team will be more successful in the long run, the Chiefs or the Ravens?''';
                                            topic3 = '''Which WR in the league is the most valuable to their team, Julio Jones or Michael Thomas?''';
                                            topic4 = '''What QB would you build around Tua Tagovailoa or Joe Burrow?''';
                                            topic5 = '''Whats a better fit for the Chargers Can Newton or a rookie draft pick?''';
                                            _showQuestionPanel();
                                          });
                                        }, child: null,
                                      ),
                                    )
                                  ],
                                )
                              ),
                              Text(
                                'Debates',
                                style: TextStyle(
                                  fontSize: 40,
                                  color: Color(0xfffffafa),
                                ),
                              ),
                              SizedBox(
                                height: 400.0,
                                child: ChatList(),
                              )
                            ]
                          ),     
                        ]
                      ),
                    ),
                  ],
                ),
              ),
            ]), 
        bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors. grey[50],
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat_bubble),
                  title: Text('Debate Chats'),
                  backgroundColor: Colors.yellow
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.table_chart),
                  title: Text('Tournament Screen'),
                  backgroundColor: Colors.yellow
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people),
                  title: Text('Judge'),
                  backgroundColor: Colors.yellow,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text('Profile'),
                  backgroundColor: Colors.yellow
                ),
              ],
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                }
              );
            },
          ),
      )
    );
    });
  }
}

