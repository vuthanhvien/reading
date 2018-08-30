import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newapp/screens/search/index.dart';
import 'package:newapp/widgets/book.dart';
import 'package:newapp/widgets/category.dart';

import 'package:newapp/services/api.dart';

class NewPage extends StatefulWidget {
  @override
  _NewPageState createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  ApiService apiService = new ApiService();
  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() {
    getBooks();
    getAuthors();
    getCategories();
    getPopularBook();
  }

  var isSearch = false;
  Map newBooks;
  Map bestBooks;
  Map authors;
  Map yourBooks;
  Map popularBooks;
  var categories;
  void _searchAction(searchKey) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Search(searchKey)));
  }

  getBooks() {
    apiService.getNewBook().then((value) {
      setState(() {
        yourBooks = value;
      });
    });
  }

  getPopularBook() {
    apiService.getPopularBook().then((value) {
      setState(() {
        popularBooks = value;
        bestBooks = value;
        newBooks = value;
      });
    });
  }

  getAuthors() {
    apiService.getAuthor().then((value) {
      setState(() {
        authors = value;
      });
    });
  }

  getCategories() {
    apiService.getCategories().then((value) {
      setState(() {
        categories = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Mỗi ngày 1 cuốn sách',
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
                style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xff444444),
                ),
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
                ),
                onChanged: (value) {
                  setState(() {});
                },
                onSubmitted: (value) {
                  // getBooks();
                  _searchAction(value);
                },
              ),
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
            onPressed: () {
              loadData();
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          // Sliders(sliders),
          HeaderTilte('Sách dành cho bạn mỗi ngày'),
          yourBooks != null ? BookListGrid(yourBooks) : Container(),
          HeaderTilte('Sách nổi tiếng'),
          popularBooks != null ? BookListGrid(popularBooks) : Container(),
          HeaderTilte('Tác giả'),
          AuthorList(authors),
          HeaderTilte('Sách mới nhất'),
          newBooks != null ? BookListGrid(newBooks) : Container(),
          HeaderTilte('Tủ sách kinh điển'),
          bestBooks != null ? BookListGrid(bestBooks) : Container(),
          HeaderTilte('Thể loại'),
          categories != null ? CategoryList(categories) : Container(),
          // HeaderTilte('Bình luận mới'),
          Container(height: 50.0)
        ],
      ),
    );
  }
}

class HeaderTilte extends StatelessWidget {
  final String title;

  HeaderTilte(this.title);

  @override
  Widget build(context) {
    return Container(
      padding:
          EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0, top: 15.0),
      child: Row(
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(15.0),
              width: 3.0,
              height: 25.0,
              color: Color.fromARGB(100, 10, 182, 162)),
          Container(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: 'RobotoSlab',
                fontWeight: FontWeight.w700,
                color: Color(0xFF00995c),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BookListHoz extends StatelessWidget {
  final data;

  BookListHoz(this.data);

  @override
  Widget build(context) {
    List<Widget> list = new List();
    data.forEach((key, value) {
      list.add(BookThumnail(value, key));
    });
    return Container(
      height: 270.0,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: list,
      ),
    );
  }
}

class AuthorList extends StatelessWidget {
  final data;

  AuthorList(this.data);

  @override
  Widget build(context) {
    List<Widget> list = new List();
    data.forEach((key, value) {
      list.add(
        Container(
          margin: EdgeInsets.all(5.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            color: Color.fromARGB(100, 10, 0, 162),
          ),
          child: Text(
            value['name'],
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
    });
    return Container(
      height: 50.0,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: list,
      ),
    );
  }
}

class BookListGrid extends StatelessWidget {
  final data;

  BookListGrid(this.data);

  @override
  Widget build(context) {
    List<Widget> list = new List();
    if (data.length > 0) {
      data.forEach((index, value) {
        list.add(
          BookThumnail(value, index),
        );
      });
    }
    return list.length > 0
        ? Container(
            height: 270.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: list,
            ),
          )
        : Container(
            child: Text('Không thấy sách yêu cầu'),
          );
  }
}

class CategoryList extends StatelessWidget {
  final data;

  CategoryList(this.data);

  @override
  Widget build(context) {
    List<Widget> list = new List();
    data.forEach((index, value) {
      list.add(CategoryItem(value, index));
    });
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list,
    );
  }
}
