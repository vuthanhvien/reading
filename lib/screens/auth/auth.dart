import 'package:flutter/material.dart';
import 'package:newapp/screens/home/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var userName = '';
  var password = '';
  _handleSignIn() async {
    GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    FirebaseUser user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              'https://img00.deviantart.net/cb2e/i/2011/323/0/3/background_05_1600x1200_by_frostbo-d42mpk5.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://flutter.io/images/flutter-mark-square-100.png',
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'email@example.com',
                      labelStyle: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    onChanged: (value) {
                      userName = value;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 10.0,
                    top: 10.0,
                    right: 10.0,
                    bottom: 20.0,
                  ),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: '*********',
                      labelStyle: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                ),
                FlatButton(
                  color: Color(0xFF42A5F5),
                  child: Center(
                    child: Text(
                      'LOGIN',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if ((userName != '') && (password != '')) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ),
                      );
                    }
                  },
                ),
                FlatButton(
                  color: Color(0xFF42A5F5),
                  child: Center(
                    child: Text(
                      'LOGIN BY GOOGLE',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                  onPressed: () {
                    _handleSignIn();
                  },
                ),
                Container(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Please add user name',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
