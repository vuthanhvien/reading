import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:newapp/screens/category/index.dart';

class CategoryItem extends StatelessWidget {
  final data;
  final index;

  CategoryItem(this.data, this.index);

  @override
  Widget build(context) {
    double width = MediaQuery.of(context).size.width;
    print(width);
    return FlatButton(
      padding: EdgeInsets.all(0.0),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return CategoryDetail(data, index);
        }));
      },
      child: Container(
        height: 65.0,
        width: width,
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(data['image']),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
          ),
        ),
        child: Text(
          data['name'],
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
