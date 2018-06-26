//
//  EventCell.swift
//  swift-tutorial
//
//  Created by Jason Johnston on 4/5/17.
//  Copyright © 2017 Microsoft. All rights reserved.
//  Licensed under the MIT license. See LICENSE.txt in the project root for license information.
//

import Foundation
import UIKit
import SwiftyJSON

struct Event {
    let subject: String
    let start: String
    let end: String
}
let date = Date()
let calendar = Calendar.autoupdatingCurrent
var hour = calendar.component(.hour, from: date)
var minutes = calendar.component(.minute, from: date)
var days = calendar.component(.day, from: date)
var months = calendar.component(.month, from: date)
var years = calendar.component(.year, from: date)
var asd = ""
var asd2 = ""
var datevalue = ""
var endvalue = ""
var timevalue1 = ""
var startvalue1 = ""

func ttime() -> String {
    let date = Date()
    let calendar = Calendar.autoupdatingCurrent
    var hour = calendar.component(.hour, from: date)
    var minutes = calendar.component(.minute, from: date)
    var days = calendar.component(.day, from: date)
    var months = calendar.component(.month, from: date)
    var years = calendar.component(.year, from: date)
    var asd22 = ""
    var ttext = ""
    if minutes <= 9{
        asd22 = ("0\(minutes)")
        ttext = ("\(hour):\(asd22)")
    } else { ttext = ("\(hour):\(minutes)")}
    print(ttext)
    return ttext
    
}



class EventCell: UITableViewCell {
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    
    var subject: String? {
        didSet {
            subjectLabel.text = subject
        }
    }
    
    var start: String? {
        didSet {
            startLabel.text = start
        }
    }
    
    var end: String? {
        didSet {
            endLabel.text = end
        }
    }
}

class EventsDataSource: NSObject {
    let events: [Event]
    
    init(events: [JSON]?) {
        var evtArray = [Event]()
        
        if let unwrappedEvents = events {
            for (event) in unwrappedEvents {
                let newEvent = Event(
                    subject: event["subject"].stringValue,
                    start: Formatter.dateTimeTimeZoneToString(date: event["start"]),
                    end: Formatter.dateTimeTimeZoneToString(date: event["end"]))
                
                if months < 10 {
                    asd = ("0\(months)")
                    datevalue = ("\(days)/\(asd)/\(years)")
                }
                if minutes > 9 {
                    timevalue1 = ("\(hour):\(minutes)")} else {
                    asd2 = ("0\(minutes)")
                    timevalue1 = ("\(hour):\(asd2)")
                }
                //print(newEvent.end.suffix(5))
                if datevalue.prefix(10) == newEvent.start.prefix(10) {
                    if ttime() < newEvent.end.suffix(5) {
                        evtArray.append(newEvent)
                        print(ttime)
                       
                        if ttime() > newEvent.end.suffix(5) {
                            if evtArray.count != 0 {
                            evtArray.dropLast()
                        }
                        }
                    }
                }
            }
        }
        self.events = evtArray
    }
}

extension EventsDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EventCell.self)) as! EventCell
        let event = events[indexPath.row]
        cell.subject = event.subject
        cell.start = event.start
        cell.end = event.end
        return cell
    }
}
