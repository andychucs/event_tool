import 'package:flutter/foundation.dart';

//import 'package:flutter/cupertino.dart';

class Event {
  String title, location, notes;
  DateTime startDate, endDate;
  bool allDay;
  double  alarmBefore;
  //alarmBefore define a value how many minutes you want alarm before your event.

  Event({
    @required this.title,
    this.notes = '',
    this.location = '',
    @required this.startDate,
    @required this.endDate,
    this.allDay = false,
    @required this.alarmBefore,
  });
}
