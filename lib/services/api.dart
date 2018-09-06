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
    //get book in database local

    //get book in server

    //update local

    //send date to me
    print('GET NEW COMMENT');
    final response =
        await http.get('https://read-book1.firebaseio.com/comments/$book.json');

    if (response.statusCode == 200) {
      return (json.decode(response.body));
    }
  }

  Future getChapters(book) async {
    print('GET NEW CHAPter LIst');
    final response =
        await http.get('https://read-book1.firebaseio.com/chapter/$book.json');

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
}
