//
//  SwiftUIView.swift
//  testSwiftUI
//
//  Created by Arjan van der Meer on 12/07/2020.
//

import SwiftUI

struct TimerIntervalView: View {
    @State private var durationSeconds: Double = 120
    
    var body: some View {TabView(selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Selection@*/.constant(1)/*@END_MENU_TOKEN@*/) {
        Text("Short").tabItem {
            VStack
            {
                Label("Settings", systemImage: "42.circle")
                Slider(value: $durationSeconds, in: 0...300, step: 5)
                Text("\(durationSeconds) seconds is \(durationSeconds / 60) minutes")
            }
        }.tag(1)
        Text("Medium").tabItem {
            VStack
            {
                Label("Settings", systemImage: "42.circle")
                Slider(value: $durationSeconds, in: 5...120, step: 1)
                Text("\(durationSeconds*60) minutes")
            }

        }.tag(2)
    }
    }
}

struct TimerIntervalView_Previews: PreviewProvider {
    static var previews: some View {
        TimerIntervalView()
    }
}
