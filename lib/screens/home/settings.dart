import 'package:flutter/material.dart';
import 'package:SportIQ/screens/home/profilescreen.dart';
import 'package:SportIQ/screens/home/tournamentscreen.dart';
import 'package:SportIQ/services/auth.dart';
import 'debatescreen.dart';



class Settings extends StatefulWidget {
  @override
  _Settings createState() => _Settings();
}

class _Settings extends State<Settings> {

  final AuthService _auth = AuthService();
  int _currentIndex = 3;
  int screen = 0;

  @override 
  Widget build(BuildContext contxt) {

    if (_currentIndex == 0) {
      return DebateScreen();
    } else if(_currentIndex == 1) {
      return TournamentScreen();
    } else if(_currentIndex == 2) {
      return ProfileScreen();
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        title: Center(child: Text(
          'Debate Screen',
            style: TextStyle(
              fontSize: 50,
              color: Color(0xfffffafa),
            ),
          ),
        ),
      ),
      body: Column(children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: RaisedButton(
            child: Text('Sign Out'),
            color: Colors.white,
            onPressed: () async {
              dynamic result = await _auth.signOut();
              if (result == null) {
                print('error signing out');
              } else {
                print('signed out');
              }
            }
          )
        )
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
            icon: Icon(Icons.person),
            title: Text('Profile'),
            backgroundColor: Colors.yellow
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
            backgroundColor: Colors.yellow,
          )
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if(_currentIndex == 0) {
              screen = 0;
            } else if(_currentIndex == 1) {
              screen = 1;
            } else if(_currentIndex == 2) {
              screen = 2;
            }
            return screen;
          }
          );
        },
      ),
    );
  }
}