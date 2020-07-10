import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:SportIQ/models/user.dart';
import 'package:SportIQ/screens/home/profilescreen.dart';
import 'package:SportIQ/services/database.dart';

class QuestionaireScreen extends StatefulWidget {
  @override
  _QuestionaireScreen createState() => _QuestionaireScreen();
}

class _QuestionaireScreen extends State<QuestionaireScreen> {

  final _formKey = GlobalKey<FormState>();

  String team = '';
  String sport = '';

  
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    
    return StreamBuilder<UserData> (
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        UserData userData = snapshot.data;
    
        return Scaffold(
          backgroundColor: Colors.black,
          body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Center(child: Text(
                        'SportIQ',
                          style: TextStyle(
                          fontSize: 50,
                          color: Color(0xfffffafa),
                          ),
                        )
                      ),
                      SizedBox(height:  20.0),
                      Image.asset('assets/images/4AF7E887-8A50-4BB8-9E65-7422059A0920.png', width: 100.0, height: 100.0),
                      SizedBox(height:20.0),
                      Center(child: Text(
                        'We want to know more about you',
                          style: TextStyle(
                          fontSize: 20,
                          color: Color(0xfffffafa),
                          ),
                        )
                      ),
                      SizedBox(height:20.0),
                      Center(child: Text(
                        'My Favorite Sport is:',
                          style: TextStyle(
                          fontSize: 20,
                          color: Color(0xfffffafa),
                          ),
                        )
                      ),
                      SizedBox(height:20.0),
                      Center(
                        child: Column( children: <Widget>[
                          Center(
                            child: Row( children: <Widget>[
                            Container(
                               height: 100.0,
                               width: 25.0,
                             ), 
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
                                 onPressed: () {setState(() {
                                   sport = 'basketball';
                                 });
                                 }, child: null,
                               ),
                             ),
                             Container(
                               height: 100.0,
                               width: 50.0,
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
                                 onPressed: () {setState(() {
                                   sport = 'football';
                                 });
                                 }, child: null,
                               ),
                             )
                            ] 
                            ),
                          )
                        ],
                        ),
                      ),
                      SizedBox(height:20.0),
                      Center(child: Text(
                        'My Favorite Team is:',
                          style: TextStyle(
                          fontSize: 20,
                          color: Color(0xfffffafa),
                          ),
                        )
                      ),
                      SizedBox(height:20.0),
                      TextFormField(
                        //initialValue: userData.team,
                          decoration: InputDecoration(
                            enabledBorder: new UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: new UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                            hintText: 'Team',
                            hintStyle: TextStyle(color: Colors.white)
                          ),
                          style: TextStyle(color: Colors.white),
                          validator: (val) => val.isEmpty ? 'Enter Valid Team' : null,
                          onChanged: (val) {
                            setState(() => team = val);
                          }
                        ),
                        Center(
                          child: RaisedButton(
                            child: Text(
                              'Continue',
                            ),
                            onPressed: () async {
                              await DatabaseService(uid: user.uid).updateUserData(
                                userData.uid ?? userData.uid,
                                sport ?? userData.sport, 
                                userData.name ?? userData.name, 
                                team ?? userData.team, 
                                userData.debatesWon ?? userData.debatesWon, 
                                userData.tournamentsWon ?? userData.tournamentsWon,
                                1 ?? userData.registered,
                                userData.image ?? userData.image,
                                userData.topicChoice ?? userData.topicChoice,
                                userData.sportDebateChoice ?? userData.sportDebateChoice,
                                userData.debateSide ?? userData.debateSide,
                                0 ?? userData.judge,
                                userData.idTo ?? userData.idTo,
                                userData.idFrom ?? userData.idFrom,
                              ); 
                              
                              return ProfileScreen();
                            
                            }
                          ),
                        ),
                  ],
                ),
              ),
            )
          )
        );
      }
    );
  }
}