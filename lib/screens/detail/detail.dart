import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:newapp/widgets/menutab.dart';
import 'read/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:newapp/services/api.dart';

class Detail extends StatefulWidget {
  final data;
  final index;

  Detail(this.data, this.index);

  @override
  _DetailState createState() => new _DetailState();
}

class _DetailState extends State<Detail> {
  var data;
  var image = '';
  var index = '';
  var description = '';
  var name = '';
  var author = '';
  int chapterListLength = 0;
  Map chapterList;
  int commentListLengh = 0;
  var commentList;

  ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    image = widget.data['image'];
    index = widget.index;
    name = widget.data['name'];
    description = widget.data['description'];
    chapterList = widget.data['chapter'];
    chapterListLength = chapterList.length;
    getComment();
  }

  var tab = 'Mô tả';

  getComment() async {
    apiService.getComments(index).then((value) {
      setState(() {
        if (value != null) {
          commentList = value;
          commentListLengh = commentList.length;
        }
      });
    });
  }

  _loveThis() {
    getComment();
  }

  _saveBook() async {
    print('Start save');
    var json = new JsonCodec();
    var s = json.encode({data: 'data'});
    print(s);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('book', widget.data['Name']);
    await prefs.setString('book', widget.data['Name']);
    print('done');
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xffe6fff5),
        elevation: 0.0,
        centerTitle: true,
        // automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: Icon(
            IconData(
              0xf404,
              fontFamily: 'CupertinoIcons',
              fontPackage: 'cupertino_icons',
            ),
          ),
          iconSize: 42.0,
          color: Color(0xFF00995c),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              _loveThis();
            },
            icon: Icon(
              IconData(
                0xf442,
                fontFamily: 'CupertinoIcons',
                fontPackage: 'cupertino_icons',
              ),
            ),
            color: Color(0xFF00995c),
          ),
        ],
      ),
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Color(0xffe6fff5),
            padding: EdgeInsets.all(10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: Container(
                    height: 200.0,
                    width: 120.0,
                    decoration: BoxDecoration(
                      color: const Color(0xff7c94b6),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(image),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(new Radius.circular(10.0)),
                    ),
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(left: 15.0, top: 15.0),
                    width: screenWidth - 140.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          name,
                          // overflow: TextOverflow.fade,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF00995c),
                            fontSize: 20.0,
                          ),
                        ),
                        Text(
                          author,
                          // overflow: TextOverflow.fade,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color(0xff555555),
                            fontSize: 14.0,
                          ),
                        ),
                        Container(
                          height: 10.0,
                        ),
                        Row(
                          children: <Widget>[
                            FlatButton(
                              color: Color(0xff0066ff),
                              onPressed: () {},
                              child: Text(
                                'Đọc chương đầu',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            IconButton(
                              color: Color(0xff009933),
                              onPressed: () {
                                _saveBook();
                              },
                              icon: Icon(
                                IconData(0xf408,
                                    fontFamily: 'CupertinoIcons',
                                    fontPackage: 'cupertino_icons'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ))
              ],
            ),
          ),
          MenuTab(
            menu: [
              'Mô tả',
              'Mục lục ($chapterListLength)',
              'Đánh giá ($commentListLengh)',
            ],
            onChanged: (tabChanged) {
              setState(() {
                tab = tabChanged;
              });
            },
          ),
          tab == 'Mô tả'
              ? Container(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    description,
                    // textAlign: TextAlign.start,
                  ),
                )
              : Container(),
          tab == 'Mục lục ($chapterListLength)'
              ? Container(
                  child: ChapList(dataList: chapterList),
                )
              : Container(),
          tab == 'Đánh giá ($commentListLengh)'
              ? Container(
                  child: commentList != null
                      ? CommentList(dataList: commentList)
                      : Container(),
                )
              : Container(),
        ],
      ),
    );
  }
}

class ChapList extends StatefulWidget {
  final dataList;
  ChapList({Key key, this.dataList: false}) : super(key: key);
  _ChapListState createState() => _ChapListState();
}

class _ChapListState extends State<ChapList> {
  var index = '';

  @override
  void initState() {
    super.initState();
  }

  Widget build(context) {
    var index = 0;
    List<Widget> chapList = List();
    double width = MediaQuery.of(context).size.width;
    widget.dataList.forEach((key, item) {
      print(item);
      chapList.add(
        Container(
          width: width,
          padding:
              EdgeInsets.only(left: 15.0, top: 5.0, bottom: 5.0, right: 15.0),
          decoration: BoxDecoration(
            color: index % 2 == 0 ? Color(0xfff4f4f4) : Colors.white,
          ),
          child: FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Read(item),
                ),
              );
            },
            child: Text(
              item['name'],
              textAlign: TextAlign.start,
            ),
          ),
        ),
      );
      index = index + 1;
    });

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: chapList,
      ),
    );
  }
}

class CommentList extends StatefulWidget {
  final dataList;
  CommentList({Key key, this.dataList: Map}) : super(key: key);
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  var index = '';

  @override
  void initState() {
    super.initState();
  }

  Widget build(context) {
    var index = 0;
    List<Widget> commentList = List();
    double width = MediaQuery.of(context).size.width;
    widget.dataList.forEach((key, item) {
      commentList.add(
        Container(
            width: width,
            padding:
                EdgeInsets.only(left: 15.0, top: 5.0, bottom: 5.0, right: 15.0),
            decoration: BoxDecoration(
              color: Color(0xfff4f4f4),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: Colors.black38,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: item['avatar'],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item['user'],
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      item['content'],
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ],
            )),
      );
      index = index + 1;
    });

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: commentList,
      ),
    );
  }
}
