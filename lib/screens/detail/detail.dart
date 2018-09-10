import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:newapp/widgets/menutab.dart';
import 'read/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';
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
  var description = '.......................................';
  var name = '.......................................';
  var author = '.......................................';
  int chapterListLength = 0;
  int commentListLengh = 0;
  bool loading = false;
  Map chapterList;
  Map commentList;

  var isSave = false;

  ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    index = widget.index;
    image = widget.data['image'];
    name = widget.data['name'];
    author = widget.data['author'];
    description = widget.data['description'];
    // getDetail();
    getComment();
    getChapters();
    checkSave();
  }

  var tab = 'Mô tả';

  getDetail() async {
    apiService.getBookDetail(index).then((value) {
      setState(() {
        if (value != null) {
          image = value['image'];
          name = value['name'];
          author = value['author'];
          description = value['description'];
        }
      });
    });
  }

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

  getChapters() async {
    apiService.getChapters(index).then((value) {
      setState(() {
        loading = true;
        if (value != null) {
          chapterList = value;
          chapterListLength = chapterList.length;
        }
      });
    });
  }

  _saveBook() async {
    Map<dynamic, dynamic> dataSave = new Map();
    Map<dynamic, dynamic> bookDetail = new Map();

    bookDetail['image'] = image;
    bookDetail['name'] = name;
    bookDetail['author'] = author;
    bookDetail['description'] = description;

    dataSave['detail'] = bookDetail;
    dataSave['chapterList'] = chapterList;
    //save all chapter by get all chapper
    await apiService.getContentChapters(index).then((value) {
      loading = true;
      if (value != null) {
        dataSave['contentChapterList'] = value;
      }
    });

    var string = json.encode(dataSave);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('BOOK_' + index, string);
    // checkSave();
  }

  checkSave() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var string = prefs.getKeys();
    string.forEach((item) {
      if (item == 'BOOK_' + index) {
        String data = prefs.getString('BOOK_' + index);
        print(data);
        setState(() {
          isSave = true;
        });
      }
    });
  }

  Future<Null> _handleRefresh() async {
    await getDetail();
    await getComment();
    await getChapters();
    return null;
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
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: ListView(
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
                        borderRadius:
                            BorderRadius.all(new Radius.circular(10.0)),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15.0, top: 5.0),
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
                            loading
                                ? Container(
                                    child: isSave
                                        ? FlatButton(
                                            color: Color(0xff009933),
                                            onPressed: () {},
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  IconData(0xf3ff,
                                                      fontFamily:
                                                          'CupertinoIcons',
                                                      fontPackage:
                                                          'cupertino_icons'),
                                                  color: Colors.white,
                                                ),
                                                Container(width: 5.0),
                                                Text(
                                                  'Đã tải',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ))
                                        : FlatButton(
                                            color: Color(0xff009933),
                                            onPressed: () {
                                              _saveBook();
                                            },
                                            child: Text(
                                              'Lưu về máy',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                  )
                                : Container(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            MenuTab(
              menu: [
                'Mô tả',
                'Mục lục ($chapterListLength)',
                // 'Đánh giá ($commentListLengh)',
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
                    child: ChapList(chapterList, widget.index),
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
      ),
    );
  }
}

class ChapList extends StatefulWidget {
  final dataList;
  final bookId;
  ChapList(this.dataList, this.bookId);
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
    if (widget.dataList != null) {
      widget.dataList.forEach((key, item) {
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
                    builder: (context) => Read(key),
                  ),
                );
              },
              child: Text(
                key,
                textAlign: TextAlign.start,
              ),
            ),
          ),
        );
        index = index + 1;
      });
    }

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: chapList != null ? chapList : Container(),
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
