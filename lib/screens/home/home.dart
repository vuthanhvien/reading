import 'package:flutter/material.dart';
import 'my/index.dart';
import 'new/index.dart';
import 'history/index.dart';
import 'profile/index.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Home"),
      // ),
      body: Stack(
        children: <Widget>[
          Offstage(
            offstage: index != 0,
            child: TickerMode(
              enabled: index == 0,
              child: NewPage(),
            ),
          ),
          Offstage(
            offstage: index != 1,
            child: TickerMode(
              enabled: index == 1,
              child: MyPage(),
            ),
          ),
          Offstage(
            offstage: index != 2,
            child: TickerMode(
              enabled: index == 2,
              child: HistoryPage(),
            ),
          ),
          Offstage(
            offstage: index != 3,
            child: TickerMode(
              enabled: index == 3,
              child: ProfilePage(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Color(0xFF00995c),
        currentIndex: index, // this will be set when a new tab is tapped
        iconSize: 32.0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              IconData(index == 0 ? 0xf450 : 0xf44f,
                  fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'),
            ),
            title: Text(
              '',
              style: TextStyle(fontSize: 0.0),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              IconData(index == 1 ? 0xf3ea : 0xf3e9,
                  fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'),
            ),
            title: Text(
              '',
              style: TextStyle(fontSize: 0.0),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              IconData(index == 2 ? 0xf3fa : 0xf3f9,
                  fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'),
            ),
            title: Text(
              '',
              style: TextStyle(fontSize: 0.0),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              IconData(index == 3 ? 0xf41a : 0xf419,
                  fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'),
            ),
            title: Text(
              '',
              style: TextStyle(fontSize: 0.0),
            ),
          ),
        ],
        onTap: (int index) {
          setState(() {
            this.index = index;
          });
        },
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
