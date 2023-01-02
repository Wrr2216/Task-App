//
//  Task_AppApp.swift
//  Task App
//
//  Created by Logan Miller on 1/2/23.
//

import SwiftUI

@main
struct Task_AppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
