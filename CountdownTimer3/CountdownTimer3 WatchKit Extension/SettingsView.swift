//
//  ContentView.swift
//  CountdownTimer WatchKit Extension
//
//  Created by Arjan van der Meer on 20/12/2020.
//

import SwiftUI

struct SettingsView: View {
    let days = [ "1", "2", "3", "4", "5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"]
    let months = [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    let years = ["2020", "2021", "2022"]
    let yearsOffset:Int
    
    let hours = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23"]
    let minutes = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"]
    let seconds = ["0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59"]
    
    @State private var day:Int=20
    @State private var month:Int=10
    @State private var year:Int=2020
    @State private var hour:Int=0
    @State private var minute:Int=0
    @State private var second:Int=0
    
    @ObservedObject var event:CalendarEvent
    
    init(event:CalendarEvent)
    {
        self.event = event;
        yearsOffset = Int(years[0])!
    }
    var body: some View {
        GeometryReader { geometry in
            ScrollView  {
                ScrollViewReader { scrollView in
                    VStack(alignment: .leading){
                        Text("Settings")
                        HStack{
                            /*,onCommit: saveName*/
                            Picker(selection: $day, label: Text("Day")){
                                ForEach(0 ..< days.count) {
                                    Text(String(self.days[$0]))
                                }
                            }
                            Picker(selection: $month, label: Text("Month")) {
                                ForEach(0 ..< months.count) {
                                    Text(String(self.months[$0]))
                                }
                            }
                            Picker(selection: $year, label: Text("Year")) {
                                ForEach(0 ..< years.count) {
                                    Text(String(self.years[$0]))
                                }
                            }
                        }
                        HStack{
                            Picker(selection: $hour, label: Text("Hour")) {
                                ForEach(0 ..< hours.count) {
                                    Text(String(self.hours[$0]))
                                }
                            }
                            Picker(selection: $minute, label: Text("Minute")) {
                                ForEach(0 ..< minutes.count) {
                                    Text(String(self.minutes[$0]))
                                }
                            }
                            Picker(selection: $second, label: Text("Second")) {
                                ForEach(0 ..< seconds.count) {
                                    Text(String(self.seconds[$0]))
                                }
                            }
                        }
                        /*
                         Text(Self.formatter.string(from: seconds)!)
                         .font(.title)
                         .digitalCrownRotation(
                         $seconds, from: 0, through: 60 * 60 * 24 - 1, by: 60)
                         */
                        
                    }.onAppear(perform: loadCalendar).onDisappear(perform: saveCalendar).id("view").frame(
                        width: geometry.size.width,
                        height: geometry.size.height,
                        alignment: .topLeading)

                    Button(action: {
                        setCalendar(month:12,day:25,hour:0,minute:0,second:0)
                        scrollView.scrollTo("view")
                    })
                    {
                        Text("Christmas")
                    }
                    Button(action: {
                        setCalendar(month:12,day:31,hour:23,minute:59,second:0)
                        scrollView.scrollTo("view")
                    })
                    {
                        Text("New Years Eve")
                    }
                    Button(action: {
                        setCalendar(month:1,day:1,hour:0,minute:0,second:0)
                        scrollView.scrollTo("view")
                    })
                    {
                        Text("New Year")
                    }

                    //      return;
                    //    }
                    // .onAppear() {
                    // scrollView.scrollTo("view")
                }
                //                ).background(Color.black)
            }
        }
    }
    func loadCalendar()
    {
        guard let eventData = event.getCalendarComponents() else {
            return
        }
        setCalendar(year:eventData.year, month:eventData.month, day:eventData.day, hour:eventData.hour, minute:eventData.minute, second:eventData.second)
    }
    func setCalendar(year:Int=0, month:Int, day:Int, hour:Int, minute:Int, second:Int)
    {
        if ( year == 0 )
        {
            self.year = CalendarEvent.determineYear(month: month, day: day, hour: hour, minute: minute, second: second)-yearsOffset
        } else {
            self.year = year-yearsOffset
        }
        self.month = month-1
        self.day=day-1
        self.hour=hour
        self.minute=minute
        self.second=second
    }
    func saveCalendar()
    {
        event.setCalendarComponents(year: self.year+yearsOffset, month:self.month+1, day:self.day+1, hour:self.hour, minute:self.minute, second:self.second)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(event:CalendarEvent(description: "Guy Fawkes Day", year: 0, month: 11, day: 5, hour: 20, minute: 0, second: 0))
    }
}
