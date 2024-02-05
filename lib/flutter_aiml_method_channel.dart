import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'flutter_aiml_platform_interface.dart';

/// An implementation of [FlutterAimlPlatform] that uses method channels.
class MethodChannelFlutterAiml extends FlutterAimlPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_aiml');

   @override
  Future<void> invokeSetup() async {
    var externaldirPath = await getExternalStorageDirectory();
    var dir = externaldirPath!.path.toString();
    await methodChannel.invokeMethod('setup', {'dir': dir});
  }

  @override
  Future<String> getResponse({required String message}) async {
    var response = '';
    try {
      final String result =
          await methodChannel.invokeMethod('getResponse', {'msg': message});
      response = result;
    } catch (e) {
      response = 'unknown';
    }
    return response;
  }
}
