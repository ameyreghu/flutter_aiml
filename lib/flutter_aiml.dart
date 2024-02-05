
import 'flutter_aiml_platform_interface.dart';

class FlutterAiml {
  Future<void> invokeSetup() {
    return FlutterAimlPlatform.instance.invokeSetup();
  }

  Future<String> getResponse({required String message}) {
    return FlutterAimlPlatform.instance.getResponse(message: message);
  }
}
