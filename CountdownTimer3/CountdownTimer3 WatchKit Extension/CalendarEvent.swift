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
    
    static var thisYear:Int = Calendar.current.dateComponents([.year], from: Date()).year!
    init()
    {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.refreshTimer()
        }
    }
    init ( description:String, year:Int, month:Int, day:Int, hour:Int, minute:Int, second:Int)
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
    init (eventName:String, year:Int, month:Int, day:Int, hour:Int=0, minute:Int=0, second:Int=0)
    {
        var components = DateComponents()
        components.day = day
        components.month = month
        components.year = year
        components.hour = hour
        components.minute = minute
        components.second = second
        eventDate =  Calendar.current.date(from: components)
        
        self.eventName = eventName
        self.refreshTimer()
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.refreshTimer()
        }
        
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
        self.weeksLeft = 0
        self.daysLeft = difference.day
        
        if(self.daysLeft != nil)
        {
            if ( self.daysLeft!/7 > 0 )
            {
                self.weeksLeft = self.daysLeft!/7
            }
            self.daysLeft = self.daysLeft!%7
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
