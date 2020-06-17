import 'main.dart';

class Config {
  void exitFlutter() {
    PlatformChannel.invokeMethod('exitFlutter');
  }

  void gotoSecondPage() {
    PlatformChannel.invokeMethod('gotoSecondPage', <String, dynamic>{
      'id': 12345,
      'name': "Manhnd MobileApp",
    });
  }
}
