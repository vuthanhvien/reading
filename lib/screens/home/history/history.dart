import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  var type = 'world';
  void _select(data) {
    setState(() {
      type = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Cộng đồng',
          style: TextStyle(
            fontFamily: 'RobotoSlab',
            fontWeight: FontWeight.w700,
            color: Color(0xFF00995c),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: Container(
            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5.0),
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _select('world');
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 25.0, right: 25.0, top: 8.0, bottom: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFF00995c),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5.0),
                      ),
                      color: type == 'world'
                          ? Color(0xFF00995c)
                          : Color(0x00000000),
                    ),
                    child: Text(
                      'Khám phá',
                      style: TextStyle(
                        fontFamily: 'RobotoSlab',
                        fontWeight: FontWeight.w800,
                        color: type == 'world'
                            ? Color(0xffffffff)
                            : Color(0xFF00995c),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _select('my');
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        left: 25.0, right: 25.0, top: 8.0, bottom: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFF00995c),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0),
                      ),
                      color:
                          type == 'my' ? Color(0xFF00995c) : Color(0x00000000),
                    ),
                    child: Text(
                      'Yêu thích',
                      style: TextStyle(
                        fontFamily: 'RobotoSlab',
                        fontWeight: FontWeight.w800,
                        color: type == 'my'
                            ? Color(0xffffffff)
                            : Color(0xFF00995c),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Color(0xffe6fff5),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            color: Color(0xFF00995c),
            icon: Icon(
              IconData(0xf39d,
                  fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        child: Text('Mail page'),
      ),
    );
  }
}
