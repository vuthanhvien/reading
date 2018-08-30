import 'package:flutter/material.dart';

class Read extends StatefulWidget {
  final data;

  Read(this.data);
  // Read({Key key, this.data}) : super(key: key);

  @override
  _ReadState createState() => new _ReadState();
}

class _ReadState extends State<Read> {
  // final data;
  void initState() {
    super.initState();
  }

  var lightDart = 10.0;
  var themeDart = false;
  void _onLightDartChange(value) {
    setState(() {
      lightDart = value;
    });
  }

  void _onThemeDartChange(value) {
    print(value);
    setState(() {
      themeDart = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
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
        title: Text(
          widget.data['Name'],
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFF00995c),
          ),
        ),
        backgroundColor: themeDart ? Color(0xff333333) : Color(0xffe6fff5),
        actions: <Widget>[
          IconButton(
            color: Color(0xFF00995c),
            icon: Icon(
              IconData(0xf39d,
                  fontFamily: 'CupertinoIcons', fontPackage: 'cupertino_icons'),
            ),
            onPressed: () {
              showDialog(
                context: context,
                child: MyDialog(
                  onLightDartChange: _onLightDartChange,
                  initialLightDart: lightDart,
                  initialThemeDart: themeDart,
                  onThemeDartChange: _onThemeDartChange,
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            color: themeDart ? Color(0xff333333) : Color(0xffffffff),
            padding: EdgeInsets.all(15.0),
            child: Text(
              widget.data['Content'],
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 16.0,
                color: themeDart ? Color(0xffffffff) : Color(0xff000000),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyDialog extends StatefulWidget {
  const MyDialog({
    this.onLightDartChange,
    this.initialLightDart,
    this.initialThemeDart,
    this.onThemeDartChange,
  });

  final double initialLightDart;
  final bool initialThemeDart;
  final void Function(double) onLightDartChange;
  final void Function(bool) onThemeDartChange;

  @override
  State createState() => new MyDialogState();
}

class MyDialogState extends State<MyDialog> {
  bool themeDart;
  double lightDart;

  @override
  void initState() {
    super.initState();
    lightDart = widget.initialLightDart;
    themeDart = widget.initialThemeDart;
  }

  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.all(15.0),
      title: Text('Điều chỉnh chế độ đọc'),
      children: <Widget>[
        Text('Điều chỉnh độ sáng tối'),
        Container(
          padding: EdgeInsets.all(10.0),
          child: Slider(
            label: 'Sáng tối',
            value: lightDart,
            onChanged: (value) {
              setState(() {
                lightDart = value;
                widget.onLightDartChange(value);
              });
            },
            min: 0.0,
            max: 100.0,
          ),
        ),
        CheckboxListTile(
          isThreeLine: false,
          title: Text('Nền tối'),
          value: themeDart,
          onChanged: (value) {
            setState(() {
              themeDart = value;
              widget.onThemeDartChange(value);
            });
          },
        )
      ],
    );
  }
}
