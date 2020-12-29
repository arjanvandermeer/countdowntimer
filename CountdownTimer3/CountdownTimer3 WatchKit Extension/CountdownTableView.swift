//
//  ContentView.swift
//  CountdownTimer WatchKit Extension
//
//  Created by Arjan van der Meer on 20/12/2020.
//

import SwiftUI


struct CountdownTableView: View {
    @ObservedObject var event:CalendarEvent
    
    init(event:CalendarEvent)
    {
        self.event=event
        self.event.useWeeks=false
    }
    var body: some View {
        GeometryReader { geometry in
            var label = CountdownLabelFormatter(labels:6)
            ScrollViewReader { scrollView in
                ScrollView  {
                    NavigationLink(destination: SettingsView(event:event)) {
                        Text(String("Settings"))
                    }.onDisappear(perform: {event.saveToDefaults()})
                    VStack(alignment: .leading){
                        HStack{
                            Spacer()
                            VStack{
                                Text(String(event.yearsLeft!)).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.system(size: 45)).minimumScaleFactor(1)
                                label.format(singleLabel:"year", multipleLabel:"years", amount:event.yearsLeft).font(.system(size: 10))
                            }
                            Spacer()
                            VStack{
                                Text(String(event.monthsLeft!)).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.system(size: 45)).minimumScaleFactor(1)
                                label.format(singleLabel:"month", multipleLabel:"months", amount:event.monthsLeft).font(.system(size: 10))
                            }
                            Spacer()
                            VStack{
                                Text(String(event.daysLeft!)).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.system(size: 45)).minimumScaleFactor(1)
                                label.format(singleLabel:"day", multipleLabel:"days", amount:event.daysLeft).font(.system(size: 10))
                            }
                            Spacer()
                        }.frame(
                            width: geometry.size.width,
                            height: geometry.size.height/2,
                            alignment: .center /*topLeading*/
                        )
                        HStack{
                            Spacer()
                            VStack{
                                Text(String(event.hoursLeft!)).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.system(size: 45)).minimumScaleFactor(1)
                                label.format(singleLabel:"hour", multipleLabel:"hours", amount:event.hoursLeft).font(.system(size: 10))
                            }
                            Spacer()
                            VStack{
                                Text(String(event.minutesLeft!)).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.system(size: 45)).minimumScaleFactor(1)
                                label.format(singleLabel:"minute", multipleLabel:"minutes", amount:event.minutesLeft).font(.system(size: 10))
                            }
                            Spacer()
                            VStack{
                                Text(String(event.secondsLeft!)).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).font(.system(size: 45)).minimumScaleFactor(1)
                                label.format(singleLabel:"second", multipleLabel:"seconds", amount:event.secondsLeft).font(.system(size: 10))
                            }
                            Spacer()
                        }.frame(
                            width: geometry.size.width,
                            height: geometry.size.height/2,
                            alignment: .center /*topLeading*/
                        )
                    }.id("view").frame(
                        width: geometry.size.width,
                        height: geometry.size.height,
                        alignment: .center /*topLeading*/
                    ).background(Color.black)
                }.onAppear() {
                    scrollView.scrollTo("view")
                }
            }
        }
    }
    
}
struct CountdownTableView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownTableView(event:CalendarEvent(description: "Guy Fawkes Day", month: 11, day: 5, hour: 20, minute: 0, second: 0))
    }
}
