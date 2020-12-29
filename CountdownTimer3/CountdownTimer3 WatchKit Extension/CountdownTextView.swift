//
//  ContentView.swift
//  CountdownTimer WatchKit Extension
//
//  Created by Arjan van der Meer on 20/12/2020.
//

import SwiftUI


struct CountdownTextView: View {
    @ObservedObject var event:CalendarEvent
    
    init(event:CalendarEvent)
    {
            self.event=event
    }
    var body: some View {
        GeometryReader { geometry in
            var label = CountdownTextFormatter(labels:7)
            ScrollViewReader { scrollView in
                ScrollView  {
                    NavigationLink(destination: SettingsView(event:event)) {
                        Text(String("Settings"))
                    }.onDisappear(perform: {event.saveToDefaults()})
                    VStack(alignment: .leading){
                        label.format(singleLabel:"year", multipleLabel:"years", amountLabel:event.yearsLeft)
                        label.format(singleLabel:"month", multipleLabel:"months", amountLabel:event.monthsLeft)
                        label.format(singleLabel:"week", multipleLabel:"weeks", amountLabel:event.weeksLeft)
                        label.format(singleLabel:"day", multipleLabel:"days", amountLabel:event.daysLeft)
                        label.format(singleLabel:"hour", multipleLabel:"hours", amountLabel:event.hoursLeft)
                        label.format(singleLabel:"minute", multipleLabel:"minutes", amountLabel:event.minutesLeft)
                        label.format(singleLabel:"second", multipleLabel:"seconds", amountLabel:event.secondsLeft)
                    }.id("view").frame(
                        width: geometry.size.width,
                        height: geometry.size.height,
                        alignment: .topLeading
                    ).background(Color.black)
                }.onAppear() {
                    scrollView.scrollTo("view")
                }
            }
        }
    }

}
struct CountdownTextView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownTextView(event:CalendarEvent(description: "Guy Fawkes Day", year: 0, month: 11, day: 5, hour: 20, minute: 0, second: 0))
    }
}
