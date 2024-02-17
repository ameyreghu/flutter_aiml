import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_aiml/flutter_aiml.dart';
import 'package:flutter_aiml/flutter_aiml_platform_interface.dart';
import 'package:flutter_aiml/flutter_aiml_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterAimlPlatform
    with MockPlatformInterfaceMixin
    implements FlutterAimlPlatform {

  @override
  Future<void> invokeSetup() {
    throw UnimplementedError();
  }

  @override
  Future<String> getResponse({required String message}) => Future.value('Hello');
  
 
}

void main() {
  final FlutterAimlPlatform initialPlatform = FlutterAimlPlatform.instance;

  test('$MethodChannelFlutterAiml is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterAiml>());
  });

  test('getResponse', () async {
    FlutterAiml flutterAimlPlugin = FlutterAiml();
    MockFlutterAimlPlatform fakePlatform = MockFlutterAimlPlatform();
    FlutterAimlPlatform.instance = fakePlatform;

    expect(await flutterAimlPlugin.getResponse(message: 'hi'), 'Hello');
  });
}
