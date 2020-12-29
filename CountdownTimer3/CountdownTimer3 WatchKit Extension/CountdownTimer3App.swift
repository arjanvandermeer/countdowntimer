//
//  CountdownTimer3App.swift
//  CountdownTimer3 WatchKit Extension
//
//  Created by Arjan van der Meer on 21/12/2020.
//

import SwiftUI

@main
struct CountdownTimer3App: App {
    @ObservedObject var event=CalendarEvent.loadFromDefaults()

    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                CountdownTextView(event:event)
            }
        }
        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
