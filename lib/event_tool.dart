import 'dart:async';

import 'package:flutter/services.dart';
import 'package:event_tool/model/event.dart';

class EventTool {
  static const MethodChannel _channel = const MethodChannel('event_tool');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<bool> addEvent(Event event) async {
    final bool isAdded =
        await _channel.invokeMethod('event_tool', <String, dynamic>{
          'title': event.title,
          'notes': event.notes,
          'location': event.location,
          'startDate': event.startDate.millisecondsSinceEpoch,
          'endDate': event.endDate.millisecondsSinceEpoch,
          'allDay': event.allDay,
          'alarmBefore': event.alarmBefore,
        });
    return isAdded;
  }
}
