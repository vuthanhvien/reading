import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:newapp/widgets/book.dart';
import 'package:newapp/services/api.dart';
import 'dart:async';

class AuthorDetail extends StatefulWidget {
  final data;
  final index;
  AuthorDetail(this.data, this.index);
  @override
  _AuthorDetailState createState() => _AuthorDetailState();
}

class _AuthorDetailState extends State<AuthorDetail> {
  var searchKey = '';
  var searching = false;
  var categories = [];
  var searchController = new TextEditingController();
  bool isLoading = true;
  ApiService apiService = ApiService();
  var isSearch = false;
  List<Widget> books = List();
  void initState() {
    super.initState();
    getBooks();
  }

  getBooks() async {
    apiService.getBookAuthor(widget.data['name']).then((value) {
      List<Widget> booksTemp = List();
      print(value);
      value.forEach((index, item) {
        booksTemp.add(BookThumnailHoz(item, index));
      });
      setState(() {
        books = booksTemp;
        isLoading = false;
      });
    });
  }

  Future<Null> _handleRefresh() async {
    await getBooks();
    return null;
  }

  // void _searchAction() {
  //   setState(() {
  //     isSearch = !isSearch;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          width: width,
          padding: EdgeInsets.all(20.0),
        ),
        elevation: 0.0,
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
        centerTitle: true,
        title: Text(
          widget.data['name'],
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFF00995c),
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
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Color(0xFF00995c),
                ),
              )
            : books != null && books.length > 0
                ? ListView(children: books)
                : Center(
                    child: Text('Không có dữ liệu'),
                  ),
      ),
    );
  }
}
