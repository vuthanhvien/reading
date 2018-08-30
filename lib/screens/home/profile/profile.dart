import 'package:flutter/material.dart';
import 'package:newapp/widgets/menutab.dart';
import 'package:newapp/screens/auth/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth firebase = FirebaseAuth.instance;
  bool isLogin = false;
  var name = '';
  var email = '';
  var image = '';

  @override
  void initState() {
    super.initState();
  }
  // void _setTab(data) {}

  _loginButton() {
    return Center(
      child: FlatButton(
        color: Color(0xffe6fff5),
        child: Text('Đăng nhập'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Auth(),
            ),
          );
        },
      ),
    );
  }

  _logout() {
    firebase.signOut().then((onValue) {
      setState(() {
        email = '';
        name = '';
        image = '';
        isLogin = false;
      });
    });
  }

  _userDetail() {
    return ListView(
      children: <Widget>[
        Container(
          color: Color(0xffe6fff5),
          padding: EdgeInsets.only(top: 10.0, left: 15.0, bottom: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 120.0,
                    width: 120.0,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(50, 0, 0, 0),
                          blurRadius: 5.0,
                          spreadRadius: 4.5,
                        ),
                      ],
                      color: Color(0xffe6fff5),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(image),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(new Radius.circular(60.0)),
                      border: Border.all(width: 4.0, color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            name,
                            style: TextStyle(
                              color: Color(0xFF00995c),
                              fontSize: 24.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            email,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 13.0,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 15.0),
                          child: FlatButton(
                            color: Color(0xFF00995c),
                            textColor: Colors.white,
                            child: Text('Đăng xuất'),
                            onPressed: () {
                              _logout();
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                height: 30.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        '0',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 24.0,
                        ),
                      ),
                      Text('Sách đã tải'),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        '0',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 24.0,
                        ),
                      ),
                      Text('Sách yêu thích'),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        '0',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 24.0,
                        ),
                      ),
                      Text(
                        'Bình luận',
                        style: TextStyle(
                          fontSize: 13.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        MenuTab(
          menu: [
            'Thông tin',
            'Bình luận',
          ],
          onChanged: (tab) {
            print(tab);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    firebase.onAuthStateChanged.listen((onData) {
      if (onData != null) {
        name = onData.displayName;
        email = onData.email;
        isLogin = true;
        image = onData.photoUrl;
        print(onData.photoUrl);
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xffe6fff5),
        elevation: 0.0,
        // actions: <Widget>[
        //   IconButton(
        //     color: Color(0xFF00995c),
        //     icon: Icon(
        //       IconData(0xf39d,
        //           fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'),
        //     ),
        //     onPressed: () {},
        //   ),
        // ],
      ),
      body: isLogin ? _userDetail() : _loginButton(),
    );
  }
}
