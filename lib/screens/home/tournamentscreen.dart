import 'package:SportIQ/screens/home/judgescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:SportIQ/models/sports.dart';
import 'package:SportIQ/screens/home/debatescreen.dart';
import 'package:SportIQ/screens/home/profilescreen.dart';
import 'package:SportIQ/screens/home/sportslist.dart';
import 'package:SportIQ/services/database.dart';


class TournamentScreen extends StatefulWidget {
  @override
  _TournamentScreen createState() => _TournamentScreen();
}

class _TournamentScreen extends State<TournamentScreen> {

  int _currentIndex = 1;
  int screen = 1;

  @override 
  Widget build(BuildContext contxt) {

    if (_currentIndex == 0) {
      return DebateScreen();
    } else if(_currentIndex == 2) {
      return JudgeScreen();
    } else if(_currentIndex == 3) {
      return ProfileScreen();
    }

  return StreamProvider<List<Users>>.value(
    value: DatabaseService().users,
    child: Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        title: Center(child: Text(
          'Rankings',
            style: TextStyle(
              fontSize: 50,
              color: Color(0xfffffafa),
            ),
          ),
        ),
      ),
      body: SportsList(),
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
  }
}