import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttermodule/DetailPage.dart';
import 'package:fluttermodule/HomePage.dart';

const CHANNEL = "com.manhnd.demofluttermodule";
const PlatformChannel = const MethodChannel(CHANNEL);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: "/",
      onGenerateRoute: (settings) {
        if (settings.name == "/DetailPage") {
          InitArg _initArg;
          if (settings.arguments == null) {
            _initArg = InitArg(false);
          } else {
            _initArg = settings.arguments;
          }

          // Then, extract the required data from the arguments and
          // pass the data to the correct screen.
          return MaterialPageRoute(
            builder: (context) {
              return DetailPage(_initArg);
            },
          );
        } else if (settings.name == "/homePage") {
          return MaterialPageRoute(
            builder: (context) {
              return HomePage();
            },
          );
        } else {
          return MaterialPageRoute(
            builder: (context) {
              return RootPage();
            },
          );
        }
      },
//      routes: {
//        '/': (context) => RootPage(),
//        '/homePage': (context) => HomePage(),
//        '/DetailPage': (context) => DetailPage(_initArg),
//      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class RootPage extends StatefulWidget {
  RootPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  // Screen route
  static const HOME = "HomePage";
  static const DETAIL = "DetailPage";
  static const DEFAULT = "DEFAULT";

  Widget currentScreen = HomePage();
  String title = "Default Page";

  @override
  void initState() {
    super.initState();
    PlatformChannel.setMethodCallHandler(_triggerFromNative);
  }

  Future<void> _triggerFromNative(MethodCall call) async {
    if (call.method == "notifyNavToFlutter") {
      print("duyduy _triggerFromNative notifyNavToFlutter");
      // Set transparent status bar
      // Not place in build method because it won't work from the second times navigate to Flutter
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ));
      switch (call.arguments) {
        case HOME:
          setState(() {
            title = "Home Page";
            currentScreen = HomePage();
          });
          break;
        case DETAIL:
          setState(() {
            title = "Detail Page";
            currentScreen = DetailPage(InitArg(true));
          });
          break;
        case DEFAULT:
          setState(() {
            title = "Default Page";
            currentScreen = HomePage();
          });
          break;
      }
    } else {
      print("Another call method");
    }
  }

  void _exitFlutter() {
    PlatformChannel.invokeMethod('exitFlutter');
  }

  @override
  Widget build(BuildContext context) {
    print("duyduy build RootPage");
    return currentScreen;
  }
}

class InitArg {
  final bool isInit;

  InitArg(this.isInit);
}

//@pragma('vm:entry-point')
//void partialScreenEntryPoint() => runApp(HomePage());
