//
//  CountdownTimer3App.swift
//  CountdownTimer3 WatchKit Extension
//
//  Created by Arjan van der Meer on 21/12/2020.
//

import SwiftUI

@main
struct CountdownTimer3App: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
