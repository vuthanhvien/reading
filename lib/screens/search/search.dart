import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newapp/widgets/book.dart';

class Search extends StatefulWidget {
  final String searchKey;
  Search(this.searchKey);

  @override
  _SearchState createState() => new _SearchState();
}

class _SearchState extends State<Search> with SingleTickerProviderStateMixin {
  var searchKey = '';
  var searching = false;
  var categories = [];
  var searchController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    searchKey = widget.searchKey;
    searchController.text = widget.searchKey;
    getBooks();
    // getCategories();
  }

  List<Widget> books = List();
  getBooks() async {
    var booksTemp = List<Widget>();
    QuerySnapshot data = await Firestore.instance
        .collection('Book')
        // .limit(10)
        // .where("Name", isNull: false)
        .getDocuments();

    data.documents.forEach((item) {
      print(item);
      booksTemp.add(BookThumnailHoz(item, 123));
    });
    setState(() {
      books = booksTemp;
    });
  }

  // getCategories() async {
  //   QuerySnapshot data =
  //       await Firestore.instance.collection('Category').getDocuments();
  //   setState(() {
  //     categories = data.documents;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final List<Widget> suggestList = List();
    for (final item in this.categories) {
      suggestList.add(
        GestureDetector(
          onTap: () {
            setState(() {
              searchKey = item['Name'];
              searching = true;
            });
            getBooks();
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              color: searchKey == item['Name'] ? Colors.white : Colors.white24,
            ),
            margin: EdgeInsets.all(5.0),
            padding: EdgeInsets.only(
              top: 10.0,
              left: 15.0,
              right: 15.0,
              bottom: 10.0,
            ),
            child: Text(
              item['Name'],
              style: TextStyle(),
            ),
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        // automaticallyImplyLeading: false,
        title: Container(
          padding: EdgeInsets.only(left: 20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            border: Border.all(color: Colors.black12),
          ),
          child: TextField(
            controller: searchController,
            // focusNode: FocusNode(),
            // autofocus: true,
            style: TextStyle(
              fontSize: 16.0,
              fontFamily: 'RobotoSlab',
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
                fontFamily: 'RobotoSlab',
              ),
            ),
            onChanged: (value) {
              setState(() {});
            },
            onSubmitted: (value) {
              getBooks();
              // _searchAction(value);
            },
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: Icon(
            IconData(0xf404,
                fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'),
          ),
          iconSize: 42.0,
          color: Color(0xFF00995c),
        ),
        backgroundColor: Color(0xffe6fff5),
      ),
      body: ListView(children: books),
    );
  }
}
