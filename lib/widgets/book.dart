import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:newapp/screens/detail/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookThumnail extends StatelessWidget {
  final data;
  final index;

  BookThumnail(this.data, this.index);
  @override
  Widget build(context) {
    void _bookDetail(data, index) {
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return Detail(data, index);
      }));
    }

    return GestureDetector(
      onTap: () {
        _bookDetail(data, index);
      },
      child: Container(
        margin: EdgeInsets.all(5.0),
        height: 320.0,
        width: 120.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 180.0,
              width: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(50, 0, 0, 0),
                    blurRadius: 2.1,
                    spreadRadius: 0.5,
                  ),
                ],
              ),
              child: Container(
                height: 180.0,
                width: 120.0,
                decoration: BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider('${data['image']}'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(new Radius.circular(10.0)),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 5.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.star,
                    size: 12.0,
                    color: Colors.yellow[700],
                  ),
                  Icon(
                    Icons.star,
                    size: 12.0,
                    color: Colors.yellow[700],
                  ),
                  Icon(
                    Icons.star,
                    size: 12.0,
                    color: Colors.yellow[700],
                  ),
                  Icon(
                    Icons.star,
                    size: 12.0,
                    color: Colors.yellow[700],
                  ),
                  Icon(
                    Icons.star,
                    size: 12.0,
                    color: Colors.yellow[700],
                  ),
                ],
              ),
            ),
            Container(
              child: Text(
                data['name'],
                textAlign: TextAlign.left,
                maxLines: 3,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookThumnailHoz extends StatelessWidget {
  final data;
  final index;

  BookThumnailHoz(this.data, this.index);
  @override
  Widget build(context) {
    void _bookDetail(data, index) {
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return Detail(data, index);
      }));
    }

    var screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        _bookDetail(data, index);
      },
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 180.0,
              width: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(50, 0, 0, 0),
                    blurRadius: 2.1,
                    spreadRadius: 0.5,
                  ),
                ],
              ),
              child: Container(
                height: 180.0,
                width: 120.0,
                decoration: BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider('${data['image']}'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(new Radius.circular(10.0)),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15.0),
              width: screenWidth - 140.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      data['name'],
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  data['author'] != null
                      ? Container(
                          child: Text(
                            data['author'],
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.black38,
                              fontSize: 13.0,
                            ),
                          ),
                        )
                      : Container(),
                  Container(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          size: 12.0,
                          color: Colors.yellow[700],
                        ),
                        Icon(
                          Icons.star,
                          size: 12.0,
                          color: Colors.yellow[700],
                        ),
                        Icon(
                          Icons.star,
                          size: 12.0,
                          color: Colors.yellow[700],
                        ),
                        Icon(
                          Icons.star,
                          size: 12.0,
                          color: Colors.yellow[700],
                        ),
                        Icon(
                          Icons.star,
                          size: 12.0,
                          color: Colors.yellow[700],
                        ),
                      ],
                    ),
                  ),
                  Text(
                    data['description'],
                    style: TextStyle(),
                    maxLines: 5,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
