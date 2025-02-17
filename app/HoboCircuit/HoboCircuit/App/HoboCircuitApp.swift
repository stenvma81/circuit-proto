//
//  HoboCircuitApp.swift
//  HoboCircuit
//
//  Created by Matti Stenvall on 17.2.2025.
//

import SwiftUI

@main
struct HoboCircuitApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.context)
        }
    }
}
   
