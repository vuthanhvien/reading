import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  var isSearch = false;
  // void _searchAction() {
  //   setState(() {
  //     isSearch = !isSearch;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Thư viện của tôi',
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
            child: Container(
              padding: EdgeInsets.only(left: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                border: Border.all(color: Colors.black12),
              ),
              child: TextField(
                // focusNode: FocusNode(),
                // autofocus: true,
                decoration: InputDecoration(
                  icon: Icon(
                    IconData(
                      0xf4a5,
                      fontFamily: 'CupertinoIcons',
                      fontPackage: 'cupertino_icons',
                    ),
                  ),
                  border: InputBorder.none,
                  hintText: 'Tìm kiếm tên sách hoặc tên tác giả',
                  hintStyle: TextStyle(
                    fontSize: 13.0,
                  ),
                  labelStyle: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                onChanged: (value) {
                  setState(() {});
                },
                onSubmitted: (value) {},
              ),
            ),
          ),
        ),
        backgroundColor: Color(0xffe6fff5),
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
