//
//  ContentView.swift
//  testSwiftUI
//
//  Created by Arjan van der Meer on 12/07/2020.
//

import SwiftUI

extension Date
{
    init(from timeIntervalSince:Date, by add:Double)
    {
        self.init()
        _ = self.advanced(by:add)
    }
}
struct ContentView: View {
    
    let runTime = 90
    let warnTime=5
    var timer: Timer?
    
    @State var startTime:Date?
    
    @State var timeLeft:String = ""
    @State var timerBackground = Color.white
    
    var body: some View {
        ZStack{
            VStack{
                Text(" \(timeLeft) ")
                    .background(timerBackground)
                Button(action: {
                    if startTime != nil
                    {
                        return;
                    }
                    startTime=Date()
//                    stopTime=startTime
  //                  stopTime = stopTime!.advanced(by: 90)
    //                warnTime = stopTime
      //               warnTime = warnTime!.advanced(by:-5)

                    print("timer started")
                    let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                        let now =  Date()
                        let diffComponents = Calendar.current.dateComponents([.second], from: startTime!, to: now)
                        let secondsRunning = diffComponents.second
                       timeLeft =  "\(secondsRunning)"
                        
                        if (runTime-secondsRunning! <= warnTime ) {
                            timerBackground = Color.red
                        }
                        if (secondsRunning! >= runTime ) {
                            timer.invalidate()
                            startTime = nil
                            timerBackground = Color.white
                        }
                        
                        return
                    }
                }
                )
                {
                    Text("Start Timer")
                    
                    //                    let timer = Timer.scheduledTimer(timeInterval: 1.0, target: //self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
                    
                    //                                 timer.tolerance = 0.2)
                }
            }
            //            Color.blue
            //       VStack{
            //         Text("Hello, Jasper!").font(.caption).padding()
            //       Text("How is your milk?").padding()
            // }
        }
        Picker(selection: /*@START_MENU_TOKEN@*/.constant(1)/*@END_MENU_TOKEN@*/, label: Text("Picker")) /*@START_MENU_TOKEN@*/{
            Text("Good").tag(1)
            Text("Not Good").tag(2)
        }/*@END_MENU_TOKEN@*/
        //      Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) //        "Submit"
        //    }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
