//
//  CamToolsApp.swift
//  CamTools
//
//  Created by Hab Yang on 2022/2/25.
//

import SwiftUI

@main
struct CamToolsApp: App {
    let persistenceController = PersistenceController.shared

    private let actionService = ActionService.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(actionService)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
