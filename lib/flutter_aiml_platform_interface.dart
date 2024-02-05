import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_aiml_method_channel.dart';

abstract class FlutterAimlPlatform extends PlatformInterface {
  /// Constructs a FlutterAimlPlatform.
  FlutterAimlPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterAimlPlatform _instance = MethodChannelFlutterAiml();

  /// The default instance of [FlutterAimlPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterAiml].
  static FlutterAimlPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterAimlPlatform] when
  /// they register themselves.
  static set instance(FlutterAimlPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }


  Future<void> invokeSetup() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
  Future<String> getResponse({required String message}) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
