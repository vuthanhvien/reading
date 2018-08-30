import 'package:flutter/material.dart';

class MenuTab extends StatefulWidget {
  final menu;
  final ValueChanged<String> onChanged;

  MenuTab({Key key, this.menu: false, @required this.onChanged})
      : super(key: key);
  _MenuTabState createState() => _MenuTabState();
}

class _MenuTabState extends State<MenuTab> {
  var tab = '';
  _setTab(data) {
    setState(() {
      tab = data;
      widget.onChanged(data);
    });
  }

  Widget build(context) {
    List<Container> listMenu = List();
    if (tab == '') {
      tab = widget.menu[0];
    }
    widget.menu.forEach((item) {
      listMenu.add(Container(
        child: FlatButton(
          child: Text(
            item,
            style: item == tab
                ? TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF00995c),
                  )
                : null,
          ),
          padding: EdgeInsets.only(
            left: 25.0,
            top: 15.0,
            right: 25.0,
            bottom: 15.0,
          ),
          onPressed: () {
            _setTab(item);
          },
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: item == tab ? Color(0xFF00995c) : Colors.white,
              width: 4.0,
            ),
          ),
        ),
      ));
    });
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black38,
          ),
        ),
      ),
      child: Row(
        children: listMenu,
      ),
    );
  }
}
