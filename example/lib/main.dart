import 'package:flutter/material.dart';
import 'package:event_tool/event_tool.dart';
import 'package:event_tool/model/event.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion =
      'Flutter (Channel stable, v1.9.1+hotfix.2, on Mac OS X 10.14.6 18G95)'
      'Xcode - develop for iOS and macOS (Xcode 11.0)'
      'TestPlatform:iOS13.0';

  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Event event = Event(
      title: 'Test event',
      notes: 'example',
      location: 'Flutter app',
      startDate: DateTime.now().add(Duration(minutes: 6)),
      endDate: DateTime.now().add(Duration(minutes: 7)),
      allDay: false,
      alarmBefore: 5,
    );


    return MaterialApp(
      home: Scaffold(
        key: scaffoldState,
        appBar: AppBar(
          title: const Text('Add event to calendar example'),
        ),
        body: Center(
          child: RaisedButton(
            child: Text('Add test event to device calendar'),
            onPressed: () {
              EventTool.addEvent(event).then((success) {
                scaffoldState.currentState.showSnackBar(
                    SnackBar(content: Text(success ? 'Success' : 'Error')));
              });
            },
          ),
        ),
      ),
    );
  }
}
