import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_aiml/flutter_aiml.dart';
import 'package:flutter_aiml/flutter_aiml_platform_interface.dart';
import 'package:flutter_aiml/flutter_aiml_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterAimlPlatform
    with MockPlatformInterfaceMixin
    implements FlutterAimlPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterAimlPlatform initialPlatform = FlutterAimlPlatform.instance;

  test('$MethodChannelFlutterAiml is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterAiml>());
  });

  test('getPlatformVersion', () async {
    FlutterAiml flutterAimlPlugin = FlutterAiml();
    MockFlutterAimlPlatform fakePlatform = MockFlutterAimlPlatform();
    FlutterAimlPlatform.instance = fakePlatform;

    expect(await flutterAimlPlugin.getPlatformVersion(), '42');
  });
}
