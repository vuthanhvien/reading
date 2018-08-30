import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:newapp/widgets/book.dart';
import 'package:newapp/services/api.dart';

class CategoryDetail extends StatefulWidget {
  final data;
  final index;
  CategoryDetail(this.data, this.index);
  @override
  _CategoryDetailState createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
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
    apiService.getBookSearch('').then((value) {
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
          decoration: BoxDecoration(
            image: DecorationImage(
                image: CachedNetworkImageProvider(widget.data['image']),
                fit: BoxFit.cover,
                colorFilter:
                    ColorFilter.mode(Colors.black54, BlendMode.darken)),
          ),
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
          color: Colors.white,
        ),
        centerTitle: true,
        title: Text(
          widget.data['name'],
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
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
            color: Colors.white,
            icon: Icon(
              IconData(0xf39d,
                  fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: Text('Đang tải'),
            )
          : ListView(children: books),
    );
  }
}
