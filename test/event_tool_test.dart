import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:event_tool/event_tool.dart';

void main() {
  const MethodChannel channel = MethodChannel('event_tool');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await EventTool.platformVersion, '42');
  });
}
