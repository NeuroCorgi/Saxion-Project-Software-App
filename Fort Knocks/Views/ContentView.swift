//
//  ContentView.swift
//  Fort Knocks
//
//  Created by Aleksandr Pokatilov on 23.11.2021.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData
    @State private var selection: Tab = .user
    
    enum Tab {
        case vaults
        case user
    }
    var body: some View {
        TabView(selection: $selection) {
            VaultList()
                .tabItem {
                    Label("Vaults", systemImage: "cube")
                }
                .tag(Tab.vaults)
            
            ProfileHost()
                .tabItem {
                    Label("User", systemImage: "person.circle")
                }
                .tag(Tab.user)
        }
        .onAppear {
            modelData.loadProfile()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
