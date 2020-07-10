import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:SportIQ/services/auth.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  final Function toggleQuestion;
  Register({this.toggleView, this.toggleQuestion});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>(); 

  String email = '';
  String password = '';
  String name ='';
  String error = '';
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 45.0),
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
                  Image.asset('assets/images/4AF7E887-8A50-4BB8-9E65-7422059A0920.png'),
                  SizedBox(height:20.0),
                  TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: new UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: new UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    style: TextStyle(color: Colors.white),
                    validator: (val) => val.isEmpty ? 'Enter Valid Name' : null,
                    onChanged: (val) {
                      setState(() => name = val);
                    }
                  ),
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
                    validator: (val) => val.length < 6 ? 'Enter Password with more than 6 Characters' : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    }
                  ),
                  SizedBox(height:20.0),
                  Row(
                      children: <Widget>[
                        Container(
                      height: 20.0,
                      width: 6.0,
                    ), 
                      SizedBox(height:20.0),
                      RaisedButton(
                      child: Text(
                        'Register',
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          
                          dynamic result = await _auth.registerWithEmailAndPassword(email, password, name);
                          if(result == null) {
                            setState(() => error = 'Enter Valid Email');
                          }
                        }
                      }
                    ),
                    Container(
                      height: 20.0,
                      width: 20.0,
                    ), 
                    SizedBox(height:20.0),
                      RaisedButton(
                      child: Text(
                        'Already Have an Account',
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