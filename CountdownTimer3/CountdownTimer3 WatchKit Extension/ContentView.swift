//
//  ContentView.swift
//  CountdownTimer WatchKit Extension
//
//  Created by Arjan van der Meer on 20/12/2020.
//

import SwiftUI
extension String.StringInterpolation {
    mutating func appendInterpolation(if condition: @autoclosure () -> Bool, _ literal: StringLiteralType) {
        guard condition() else { return }
        appendLiteral(literal)
    }
}
struct ContentView: View {
    //    @State var timeLeft:String = ""
    //    @State var timerBackground = Color.black
    @ObservedObject var event: CalendarEvent=CalendarEvent()
    //=CalendarEvent(eventName:"Christmas", year:2020,month:12,day:25, hour:0, minute:0)
    
    //    let colors = [Color.blue, Color.green, Color.yellow, Color.orange, Color.red]
    //    var colorindex=0
    
    private var storage = UserDefaults.standard
    
    init()
    {
        print ("Running init")
        load()
        print ("Init completed")
    }
    var body: some View {
        GeometryReader { geometry in
            var label = LabelFormatter(labels:7)
            ScrollViewReader { scrollView in
                ScrollView  {
                    NavigationLink(destination: SettingsView(event:event)) {
                        Text(String("Settings"))
                    }.onDisappear(perform: save)
                    /*Button("Change Color") {
                     changed.toggle()
                     
                     if changed {
                     colors = [.red, .green, .blue]
                     } else {
                     colors = [.orange, .pink , .yellow]
                     }*/
                    //ZStack
                    //{
                    VStack(alignment: .leading){
                        
                        //                if let yearsLeft = event.yearsLeft
                        //              {
                        //                Text(String("\(yearsLeft) year\(if:(yearsLeft != 1),"s")"))
                        //          }
                        label.format(singleLabel:"year", multipleLabel:"years", amountLabel:event.yearsLeft)
                        label.format(singleLabel:"month", multipleLabel:"months", amountLabel:event.monthsLeft)
                        label.format(singleLabel:"week", multipleLabel:"weeks", amountLabel:event.weeksLeft)
                        label.format(singleLabel:"day", multipleLabel:"days", amountLabel:event.daysLeft)
                        label.format(singleLabel:"hour", multipleLabel:"hours", amountLabel:event.hoursLeft)
                        label.format(singleLabel:"minute", multipleLabel:"minutes", amountLabel:event.minutesLeft)
                        label.format(singleLabel:"second", multipleLabel:"seconds", amountLabel:event.secondsLeft)
                        
                        
                        //              NavigationLink(destination: SettingsView(event:event)) {
                        //                Text(String("Settings"))
                        //          }.onDisappear(perform: save)
                        /*
                         Button(action: {
                         //            _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                         //              timeLeft =  "\(event.description)"
                         print ("Timer running")
                         //      return;
                         //    }
                         })*/
                        /*            {
                         Text("Start Timer")
                         }
                         }*/
                        
                        //.background(Color.red)
                        //.frame(width: 400, height: 400)
                        //.background(Color.blue)
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
    func load() {
        var description = storage.string(forKey:"description")
        let year = storage.integer(forKey:"year")
        let month = storage.integer(forKey:"month")
        let day = storage.integer(forKey:"day")
        let hour = storage.integer(forKey:"hour")
        let minute = storage.integer(forKey:"minute")
        let second = storage.integer(forKey:"second")
        
        // TODO: create a validation method within CalendarEvent
        
        //        event.setDescription(description:description)
        event.setCalendarComponents(year: year, month: month, day: day, hour: hour, minute: minute, second: second)
        //        return CalendarEvent(eventName:description ?? "", year: year, month: month, day: day, hour:hour, minute: minute, second: second)
    }
    func save()
    {
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
    
}


struct LabelFormatter
{
    var labels:Int
    var labelCounter:Int = 0
    var firstLineDisplayed = false
    
    mutating func format(singleLabel single:String, multipleLabel:String?, amountLabel:Int?) -> Text?
    {
        var amount:Int
        
        if ( amountLabel == nil)
        {
            amount = 0
        } else {
            amount = amountLabel!
        }
        
        if (!firstLineDisplayed )
        {
            if ( amount == 0 )
            {
                return nil
            } else {
                firstLineDisplayed = true
            }
        }
        
        var multiple = ""
        
        if ( multipleLabel==nil ){
            multiple=single+"s"
        } else {
            multiple = multipleLabel!
        }
        
        labelCounter += 1
        
        if(amount == 1)
        {
            return Text("\(amount) \(single)")
        } else {
            return Text("\(amount) \(multiple)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
