//testappio.dart

import 'package:flutter/services.dart';

// Helper function for stringifying map values
Map<String, String> _stringifyMap(Map<String, dynamic>? map) {
  if (map == null) return {};
  return map.map((key, value) => MapEntry(key, value.toString()));
}

enum TestAppioEnvironment { dev, staging, production }

extension EnvironmentExtension on TestAppioEnvironment {
  String get name => this.toString().split('.').last;
}

class TestAppio {
  final _TestAppioLog _log = _TestAppioLog();
  final _TestAppioBar _bar = _TestAppioBar();
  final _TestAppioUser _user = _TestAppioUser();

  final MethodChannel _methodChannel = const MethodChannel('testappio');

  Future<void> setup(String appToken, TestAppioEnvironment environment) async {
    await _methodChannel.invokeMethod('setup', <String, dynamic>{
      'appToken': appToken,
      'environment': environment.name,
    });
  }

  _TestAppioUser get user => _user;
  _TestAppioLog get log => _log;
  _TestAppioBar get bar => _bar;
}

class _TestAppioUser {
  final MethodChannel _methodChannel = const MethodChannel('testappio');

  Future<void> identify(
    String userId, {
    String? name,
    String? email,
    String? imageUrl,
    Map<String, dynamic>? traits,
  }) async {
    await _methodChannel.invokeMethod('user.identify', <String, dynamic>{
      'userId': userId,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'traits': _stringifyMap(traits),
    });
  }

  Future<void> reset() async {
    await _methodChannel.invokeMethod('user.reset');
  }
}

class _TestAppioLog {
  final MethodChannel _methodChannel = const MethodChannel('testappio');

  Future<void> event(String name, [Map<String, dynamic>? properties]) async {
    await _methodChannel.invokeMethod('log.event', <String, dynamic>{
      'name': name,
      'properties': _stringifyMap(properties),
    });
  }

  Future<void> error(String name, [Map<String, dynamic>? properties]) async {
    await _methodChannel.invokeMethod('log.error', <String, dynamic>{
      'name': name,
      'properties': _stringifyMap(properties),
    });
  }

  Future<void> screen(String name, [Map<String, dynamic>? properties]) async {
    await _methodChannel.invokeMethod('log.screen', <String, dynamic>{
      'name': name,
      'properties': _stringifyMap(properties),
    });
  }
}

class _TestAppioBar {
  final MethodChannel _methodChannel = const MethodChannel('testappio');

  Future<void> show() async {
    await _methodChannel.invokeMethod('bar.show');
  }

  Future<void> hide() async {
    await _methodChannel.invokeMethod('bar.hide');
  }
}
