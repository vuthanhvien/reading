import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future getNewBook() async {
    print('GET NEW BOOK');
    final response =
        await http.get('https://read-book1.firebaseio.com/books.json');

    if (response.statusCode == 200) {
      return (json.decode(response.body));
    }
  }

  Future getPopularBook() async {
    print('GET NEW POPU');
    final response =
        await http.get('https://read-book1.firebaseio.com/books.json');

    if (response.statusCode == 200) {
      return (json.decode(response.body));
    }
  }

  Future getCategories() async {
    print('GET NEW CATE');
    final response =
        await http.get('https://read-book1.firebaseio.com/categories.json');

    if (response.statusCode == 200) {
      return (json.decode(response.body));
    }
  }

  Future getAuthor() async {
    print('GET NEW AUTHOR');
    final response =
        await http.get('https://read-book1.firebaseio.com/author.json');

    if (response.statusCode == 200) {
      return (json.decode(response.body));
    }
  }

  Future getComments(book) async {
    print('GET NEW COMMENT');
    final response =
        await http.get('https://read-book1.firebaseio.com/comments/$book.json');

    if (response.statusCode == 200) {
      return (json.decode(response.body));
    }
  }

  Future getChapters(book) async {
    print('GET NEW CHAPter LIst' + book);
    final response = await http.get(
        'https://read-book1.firebaseio.com/chapter/$book.json?shallow=true');

    if (response.statusCode == 200) {
      return (json.decode(response.body));
    }
  }

  Future getContentChapters(book) async {
    print('GET NEW CHAPter LIst' + book);
    final response =
        await http.get('https://read-book1.firebaseio.com/chapter/$book.json');

    if (response.statusCode == 200) {
      return (json.decode(response.body));
    }
  }

  Future getBookAuthor(key) async {
    print(
        'https://read-book1.firebaseio.com/books.json?orderBy="author"&equalTo="$key"');
    final response = await http.get(
        'https://read-book1.firebaseio.com/books.json?orderBy="author"&equalTo="$key"');

    if (response.statusCode == 200) {
      return (json.decode(response.body));
    }
  }

  Future getBookSearch(key) async {
    final response = await http.get(
        'https://read-book1.firebaseio.com/books.json?startAt="$key"&orderBy="name"');

    if (response.statusCode == 200) {
      return (json.decode(response.body));
    }
  }

  Future getChapper(book, chap) async {
    final response = await http
        .get('https://read-book1.firebaseio.com/chapter/$book/$chap.json');

    if (response.statusCode == 200) {
      return (json.decode(response.body));
    }
  }

  Future getBookDetail(index) async {
    print('GET Book ' + index);
    final response =
        await http.get('https://read-book1.firebaseio.com/books/$index.json');

    if (response.statusCode == 200) {
      return (json.decode(response.body));
    }
  }
}
