import 'package:flutter/material.dart';
import 'package:SportIQ/models/user.dart';
import 'package:SportIQ/screens/home/debatescreen.dart';
import 'package:SportIQ/screens/home/judgescreen.dart';
import 'package:SportIQ/screens/home/tournamentscreen.dart';
import 'package:SportIQ/services/auth.dart';
import 'package:SportIQ/services/database.dart';
import 'package:provider/provider.dart';
import 'package:SportIQ/shared/loading.dart';



class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 3;
  String image = '';

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    final AuthService _auth = AuthService();

    if (_currentIndex == 0) {
      return DebateScreen();
    } else if(_currentIndex == 1) {
      return TournamentScreen();
    } else if(_currentIndex == 2) {
      return JudgeScreen();
    } 

      return StreamBuilder<UserData> (
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          UserData userData = snapshot.data;

          if (snapshot.hasData) {
            if(userData.sport == 'basketball') {
              image = 'assets/images/37BCA2DC-DD6D-402A-A0D3-2045F09F58D4.png';
            } else if(userData.sport == 'football') {
              image = 'assets/images/8472C55F-7AD6-43CF-909A-FFEF3BCCD58F.png';
            }
            
            return Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: Colors.black,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.exit_to_app), 
                    onPressed: () async {
                      dynamic result = await _auth.signOut();
                        if (result == null) {
                          print('error signing out');
                        } else {
                          print('signed out');
                        }
                    }
                  )
                ],
              ),
              body: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 40.0),
                        CircleAvatar(
                          radius: 75.0,
                          backgroundColor: Colors.cyan[300],
                          child: ClipOval(
                            child: SizedBox(
                              width: 130.0,
                              height: 130.0, 
                              child: Image.asset('assets/images/37BCA2DC-DD6D-402A-A0D3-2045F09F58D4.png', fit: BoxFit.fill),
                            )
                          )
                        ),
                        Text(
                          userData.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 50.0,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Center(
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 20.0),
                                  Text(
                                    'Favorite Sport:',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                    ),
                                  ),
                                  SizedBox(width: 30.0),
                                  Text(
                                    'Favorite Team:',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                    ),
                                  ),
                                ],
                              ),
                        ),
                            SizedBox(height: 10.0),
                            Expanded(
                              child: Center(
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(width: 60.0),
                                    Image.asset(
                                      image,
                                      height: 75.0,
                                      width: 75.0,
                                    ),
                                    SizedBox(width: 120.0),
                                    Text(
                                      userData.team,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25.0,                                
                                      )
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                                'Debates Participated in:',
                                style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                              ),
                            ),
                            Text(
                                userData.debatesWon,
                                style: TextStyle(
                                color: Colors.cyan[300],
                                fontSize: 50.0,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Text(
                                'Tournament Championships:',
                                style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                              ),
                            ),
                            Text(
                                userData.tournamentsWon,
                                style: TextStyle(
                                color: Colors.cyan[300],
                                fontSize: 50.0,
                              ),
                            )
                          ],
                        )
                      )
              ),
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
        );
      } else {
        return Loading();
      }
      }
    );
  }
}