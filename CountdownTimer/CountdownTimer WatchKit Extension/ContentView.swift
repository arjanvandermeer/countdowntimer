//
//  ContentView.swift
//  CountdownTimer WatchKit Extension
//
//  Created by Arjan van der Meer on 20/12/2020.
//

import SwiftUI

struct ContentView: View {
    
    @State var eventDate:Date?
    @State var timeLeft:String = ""
    @State var timerBackground = Color.black
    var timer: Timer?
    
    @ObservedObject var coreRouter: CoreRouter
    
        

            
//            if (runTime-secondsRunning! <= warnTime ) {
//                timerBackground = Color.red
//            }
  //          if (secondsRunning! >= runTime ) {
 //               timer.invalidate()
   //             startTime = nil
     //           timerBackground = Color.white
       //     }
            
          //  return
     //   }
//    }

    var body: some View {
        ZStack{
            VStack{
                Text("seconds left: \(timeLeft) ")
                    .background(timerBackground)
            Button(action: {
                if eventDate==nil
                {
                    var components = DateComponents()
                    components.day = 25
                    components.month = 12
                    components.year = 2020
                    components.hour = 0
                    components.minute = 0
                    eventDate =  Calendar.current.date(from: components)
}
                
                    print("timer started")
                _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                    let diffComponents = Calendar.current.dateComponents([.second], from: Date(), to: eventDate!)
                    let secondsRunning = diffComponents.second
                   timeLeft =  "\(secondsRunning!)"
                return;
                }
            })
            {
                Text("Start Timer")
    
            }
            }
//        Text("Hello, World!")
//            .padding()
    }
}
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
