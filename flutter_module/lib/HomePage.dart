import 'package:flutter/material.dart';
import 'package:fluttermodule/main.dart';

import 'config.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String numberRandom = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Config().exitFlutter(),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text("Hello VTP From Flutter"),
            RaisedButton(
              child: Text("Go to Detail Fultter"),
              onPressed: () {
                Navigator.pushNamed(context, "/DetailPage");
              },
            ),
            Text("$numberRandom"),
            RaisedButton(
              child: Text("Call Back from Native"),
              onPressed: () {
                randomFromNative();
              },
            ),
            RaisedButton(
              child: Text("Back"),
              onPressed: () {
                Config().exitFlutter();
              },
            )
          ],
        ),
      ),
    );
  }

  randomFromNative() {
    PlatformChannel.invokeMethod('myRandom').then((value) {
      print("value: " + value.toString());
      double number = value as double;
      setState(() {
        numberRandom = number.toString() + ": Success";
      });
    }, onError: (e) {
      print("error: " + e.toString());
      setState(() {
        numberRandom = e.toString();
      });
    }).catchError((e) {
      print("error: " + e.toString());
      setState(() {
        numberRandom = e.toString();
      });
    });
  }
}
