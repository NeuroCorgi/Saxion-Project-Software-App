//
//  ProfileEditor.swift
//  Fort Knocks
//
//  Created by Aleksandr Pokatilov on 06.01.2022.
//

import SwiftUI

struct ProfileEditor: View {
    @Binding var profile: Profile
    
    var body: some View {
        List {
            Section( header: Text("User data")) {
                HStack {
                    TextField("Username", text: $profile.name)
                }
                            
                HStack {
                    TextField("Email", text: $profile.email)
                }
            }
        }
    }
}

struct ProfileEditor_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditor(profile: .constant(.default))
    }
}
