import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  final Widget child;
  final Icon icon;
  final Color iconColor;

  Dropdown({
    Key key,
    @required this.child,
    @required this.icon,
    @required this.iconColor,
  }) : super(key: key);
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  var show = false;
  _setTab() {
    setState(() {
      show = !show;
    });
  }

  Widget build(context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      // fit: StackFit.loose,
      children: <Widget>[
        Container(
          child: IconButton(
            onPressed: () {
              _setTab();
            },
            color: widget.iconColor,
            icon: widget.icon,
          ),
        ),
        show
            ? Container(
                width: width,
                height: 500.0,
                color: Colors.black,
                child: widget.child,
              )
            : Container(),
      ],
    );
  }
}
