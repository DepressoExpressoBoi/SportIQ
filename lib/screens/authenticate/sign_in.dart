import 'package:flutter/material.dart';
import 'package:SportIQ/services/auth.dart';
import 'package:SportIQ/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  final Function toggleQuestion;
  SignIn({this.toggleView, this.toggleQuestion});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false; 

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.black,
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text(
                      'SportIQ',
                      style: TextStyle(
                      fontSize: 50,
                      color: Color(0xfffffafa),
                      ),
                    )
                  ),
                  SizedBox(height:  20.0),
                  Image.asset('assets/images/4AF7E887-8A50-4BB8-9E65-7422059A0920.png'),
                  SizedBox(height:20.0),
                    TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: new UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: new UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.white)
                      ),
                      style: TextStyle(color: Colors.white),
                      validator: (val) => val.isEmpty ? 'Enter Valid Email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      }
                    ),
                    SizedBox(height:20.0),
                    TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: new UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: new UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.white)
                      ),
                      style: TextStyle(color: Colors.white),
                      obscureText: true,
                      validator: (val) => val.length < 6 ? 'Enter Paasword with more than 6 Characters' : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      }
                    ),
                  SizedBox(height:20.0),
                  Row(
                      children: <Widget>[
                        Container(
                      height: 20.0,
                      width: 15.0,
                    ), 
                      SizedBox(height:20.0),
                      RaisedButton(
                      child: Text(
                        'Sign In',
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = _auth.signInWithEmailAndPassword(email, password);
                          if(result == null) {
                            setState(() => {
                              error = 'Enter Valid Email',
                              loading = false 
                            });
                          }
                        }
                      }
                    ),
                    Container(
                      height: 20.0,
                      width: 32.0,
                    ), 
                    SizedBox(height:20.0),
                      RaisedButton(
                      child: Text(
                        'Register an Account',
                      ),
                      onPressed: () async {
                        widget.toggleView();
                      }
                    )
                  ]
                )
              ],
          ),
            ),
        )
      )
    );
  }
}