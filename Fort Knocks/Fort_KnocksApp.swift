//
//  Fort_KnocksApp.swift
//  Fort Knocks
//
//  Created by Aleksandr Pokatilov on 23.11.2021.
//

import SwiftUI

@main
struct Fort_KnocksApp: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
    
}
