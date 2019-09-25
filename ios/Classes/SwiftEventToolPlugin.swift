import Flutter
import UIKit
import EventKit
import Foundation

extension Date {
      init(milliseconds:Double) {
          self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
      }
}

public class SwiftEventToolPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "event_tool", binaryMessenger: registrar.messenger())
    let instance = SwiftEventToolPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "event_tool" {
            let args = call.arguments as! [String:Any]
            let title = args["title"] as! String
            let notes = args["notes"] as! String
            let location = args["location"] as! String
            let alarmBefore = args["alarmBefore"] as! Double
//            let alarm = Double(alarmBefore)
            
            addEventToCalendar(title: title, notes: notes, location: location, startDate: Date(milliseconds: (args["startDate"] as! Double)), endDate: Date(milliseconds: (args["endDate"] as! Double)), allDay: args["allDay"] as! Bool, alarmBefore: alarmBefore, completion: { (success) -> Void in
            if success {
                result(true)
            } else {
                result(false)
            }
        })
    }
//    result("iOS " + UIDevice.current.systemVersion)
}
    private func addEventToCalendar(title: String!, notes: String, location: String, startDate: Date, endDate: Date, allDay: Bool, alarmBefore: Double!, completion: ((_ success: Bool) -> Void)? = nil) {
            let eventStore = EKEventStore()

            eventStore.requestAccess(to: .event, completion: { (granted, error) in
                if (granted) && (error == nil) {
                    let event = EKEvent(eventStore: eventStore)
                    event.title = title
                    event.startDate = startDate
                    event.endDate = endDate
                    event.location = location
                    event.notes = notes
                    event.isAllDay = allDay
                    let alarm = EKAlarm(relativeOffset: -60 * alarmBefore)
                    event.addAlarm(alarm)
                    event.calendar = eventStore.defaultCalendarForNewEvents
                    do {
                        try eventStore.save(event, span: .thisEvent)
                    } catch _ as NSError? {
                        completion?(false)
                        return
                    }
                    completion?(true)
                } else {
                    completion?(false)
                }
            })
    }
}
