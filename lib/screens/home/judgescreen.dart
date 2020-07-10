import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:SportIQ/models/sports.dart';
import 'package:SportIQ/models/user.dart';
import 'package:SportIQ/screens/home/debatescreen.dart';
import 'package:SportIQ/screens/home/judgelist.dart';
import 'package:SportIQ/screens/home/profilescreen.dart';
import 'package:SportIQ/screens/home/tournamentscreen.dart';
import 'package:SportIQ/services/database.dart';
import 'package:SportIQ/shared/loading.dart';


class JudgeScreen extends StatefulWidget {
  @override
  _JudgeScreen createState() => _JudgeScreen();
}

class _JudgeScreen extends State<JudgeScreen> {
  int _currentIndex = 2;

  @override 
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (_currentIndex == 0) {
      return DebateScreen();
    } else if(_currentIndex == 1) {
      return TournamentScreen();
    } else if(_currentIndex == 3) {
      return ProfileScreen();
    }
   
    return StreamBuilder<UserData> (
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        UserData userData = snapshot.data;

        if (snapshot.hasData) {

          if (userData.judge == 1){
            return StreamProvider<List<Users>>.value(
              value: DatabaseService().users,
              child: Scaffold(
                  backgroundColor: Colors.black,
                  appBar: AppBar(
                  backgroundColor: Colors.black,
                  elevation: 0.0,
                  title: Center(child: Text(
                    'Judge a Debate',
                      style: TextStyle(
                        fontSize: 40,
                        color: Color(0xfffffafa),
                      ),
                    ),
                  ),
                ),
                  body: SizedBox(
                    height: 400.0, 
                    child: JudgeList()
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
              )
            );
            } else {
            return Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
              backgroundColor: Colors.black,
              elevation: 0.0,
              title: Center(child: Text(
                'Judge a Debate',
                  style: TextStyle(
                    fontSize: 40,
                    color: Color(0xfffffafa),
                  ),
                ),
              ),
            ),
              body: Center(
                child: Text(
                  "Not a Judge Yet, Come Back Later",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                  ),
                ),
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
          }
        } else {
          return Loading();
        }
      } 
    );
  } 
} 


