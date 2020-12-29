//
//  CalendarEvent.swift
//  CountdownTimer3 WatchKit Extension
//
//  Created by Arjan van der Meer on 21/12/2020.
//
import Foundation
import SwiftUI
import Combine


extension Date {
    
    func get(_ type: Calendar.Component)-> String {
        let calendar = Calendar.current
        let t = calendar.component(type, from: self)
        return (t < 10 ? "0\(t)" : t.description)
    }
}

class CalendarEvent: ObservableObject {
    //@Published
    @Published var eventName=""
    
    var eventDate:Date!
    @Published var description=""
    @Published var yearsLeft:Int?
    @Published var monthsLeft:Int?
    @Published var weeksLeft:Int?
    @Published var daysLeft:Int?
    @Published var hoursLeft:Int?
    @Published var minutesLeft:Int?
    @Published var secondsLeft:Int?
    var timer = Timer()
    var useWeeks = true
    
    static var thisYear:Int = Calendar.current.dateComponents([.year], from: Date()).year!
    init()
    {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.refreshTimer()
        }
    }
    init ( description:String, year:Int=0, month:Int, day:Int, hour:Int, minute:Int, second:Int)
    {
        self.description = description
        setCalendarComponents(year:year, month:month, day:day, hour:hour, minute:minute, second:second)
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.refreshTimer()
        }
    }
    static func getCalendarComponents(date:Date)-> (year:Int, month:Int, day:Int, hour:Int, minute:Int, second:Int)?
    {
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        return (components.year!, components.month!, components.day!, components.hour!, components.minute!, components.second!)
    }
    func getCalendarComponents()-> (year:Int, month:Int, day:Int, hour:Int, minute:Int, second:Int)?
    {
        if ( eventDate == nil )
        {
            return nil
        }
        return CalendarEvent.getCalendarComponents(date:eventDate!)
        //        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: eventDate!)
        //        return (components.year!, components.month!, components.day!, components.hour!, components.minute!, components.second!)
    }
    static func determineYear(month:Int, day:Int, hour:Int, minute:Int, second:Int)->Int
    {
        if ( Calendar.current.date(from:DateComponents(year:thisYear, month:month, day:day, hour:hour, minute:minute, second:second))!>Date ())
        {
            return thisYear
        } else {
            return thisYear+1
        }
    }
    func setCalendarComponents(year:Int=0, month:Int, day:Int, hour:Int, minute:Int, second:Int)
    {
        if ( (year==0 || year>=CalendarEvent.thisYear ) && month > 0 && month<=12 && day>=1 && day<=31 && hour>=0 && hour<=23 && minute>=0 && minute<=59 && second>=0 && second<=59)
        {
            var components = DateComponents()
            components.day = day
            components.month = month
            
            components.hour = hour
            components.minute = minute
            components.second = second
            
            if ( year == 0 )
            {
                components.year = CalendarEvent.determineYear(month:month, day:day, hour:hour, minute:minute, second:second)
            } else {
                components.year = year
            }
            
            eventDate =  Calendar.current.date(from: components)
            
            self.refreshTimer()
            
        } else {
            eventDate = nil
            self.refreshTimer()
        }
        
    }
    
    func getDescription()->String
    {
        return self.description
    }
    func setDescription(description:String)
    {
        self.description = description
    }
    static func loadFromDefaults()->CalendarEvent {
        let storage = UserDefaults.standard
        
        let description = storage.string(forKey:"description") ?? ""
        let year = storage.integer(forKey:"year")
        let month = storage.integer(forKey:"month")
        let day = storage.integer(forKey:"day")
        let hour = storage.integer(forKey:"hour")
        let minute = storage.integer(forKey:"minute")
        let second = storage.integer(forKey:"second")
        
        return CalendarEvent(description: description, year: year, month: month, day: day, hour: hour, minute: minute, second: second)
    }
    static func saveToDefaults(event:CalendarEvent)
    {
        let storage = UserDefaults.standard
        
        storage.set(event.description, forKey:"description")
        guard let eventData = event.getCalendarComponents() else {
            return;
        }
        storage.set(eventData.year, forKey:"year")
        storage.set(eventData.month, forKey:"month")
        storage.set(eventData.day, forKey:"day")
        storage.set(eventData.hour, forKey:"hour")
        storage.set(eventData.minute, forKey:"minute")
        storage.set(eventData.second, forKey:"second")
    }
    func saveToDefaults()
    {
        CalendarEvent.saveToDefaults(event:self)
    }
    
    func refreshTimer()
    {
        let now = Date();
        
        if ( eventDate == nil || now >= eventDate!)
        {
            self.yearsLeft = 0;
            self.monthsLeft = 0;
            self.weeksLeft = 0;
            self.daysLeft = 0;
            self.hoursLeft = 0;
            self.minutesLeft = 0;
            self.secondsLeft = 0;
            return;
        }
        let difference  = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now, to: self.eventDate!)
        
        self.yearsLeft = difference.year
        self.monthsLeft = difference.month
        self.weeksLeft = nil
        self.daysLeft = difference.day
        
        if(self.daysLeft != nil)
        {
            if (useWeeks)
            {
                if ( self.daysLeft!/7 > 0 )
                {
                    self.weeksLeft = self.daysLeft!/7
                }
                self.daysLeft = self.daysLeft!%7
            }
        }
    self.hoursLeft = difference.hour
    self.minutesLeft = difference.minute
    self.secondsLeft = difference.second
    /*
     var text = " \(if:difference.day!>0, String(difference.day!)+" days, ")" + " \(if:difference.hour!>0, String(difference.hour!)+" hours, ")"
     text = text +  "\(if:difference.minute!>0, String(difference.minute!)+" minutes, ")" +  "\(if:difference.second!>0, String(difference.second!)+" seconds ")"
     self.description=text
     */
}
// public var description: String
//  {
//    let difference  = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date(), to: eventDate!)
//  var text = " \(if:difference.day!>0, String(difference.day!)+" days, ")" + " \(if:difference.hour!>0, String(difference.hour!)+" hours, ")"
//    text = text +  "\(if:difference.minute!>0, String(difference.minute!)+" minutes, ")" +  "\(if:difference.second!>0, String(difference.second!)+" seconds ")"
//     return text
//
//}


}
