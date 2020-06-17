import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttermodule/config.dart';
import 'package:fluttermodule/main.dart';

class DetailPage extends StatefulWidget {
  InitArg _initArg;

  DetailPage(this._initArg, {Key key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState(_initArg);
}

class _DetailPageState extends State<DetailPage> {
  InitArg _initArg;
  String _param = "Unknow param";

  _DetailPageState(this._initArg);

  @override
  void initState() {
    super.initState();
    _getParam();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DetailPage"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (_initArg.isInit) {
              Config().exitFlutter();
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.yellow,
        child: Column(
          children: <Widget>[
            Text("Detail VTP From Flutter"),
            Text("Param: ${_param}"),
            RaisedButton(
              child: Text("Go to Second Page"),
              onPressed: () {
                Config().gotoSecondPage();
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> _getParam() async {
    String param;
    try {
      final String result = await PlatformChannel.invokeMethod('getParam');
      param = result;
      print(param);
    } on PlatformException catch (e) {
      param = "Failed to get param: '${e.message}'";
      print(param);
    }

    setState(() {
      _param = param;
    });
  }
}
