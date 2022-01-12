//
//  ProfileView.swift
//  Fort Knocks
//
//  Created by Aleksandr Pokatilov on 07.01.2022.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            List {
                Text("Hello World!")
            }
            .navigationTitle("User")
            .toolbar {
                Button("Edit") {
                    
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
