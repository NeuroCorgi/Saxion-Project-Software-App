//
//  ProfileHost.swift
//  Fort Knocks
//
//  Created by Aleksandr Pokatilov on 06.01.2022.
//

import SwiftUI

struct ProfileHost: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showingEdit = false
    @State private var draftProfile = Profile()
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("User data")) {

                    HStack {
                        Text("Username")
                        Spacer()
                        Text(modelData.profile.name)
                            .foregroundColor(.gray)
                    }

                    HStack {
                        Text("Email")
                        Spacer()
                        Text(modelData.profile.email)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("User")
            .toolbar {
                Button("Edit") {
                    showingEdit = true
                    draftProfile = modelData.profile
                }
            }
            .sheet(isPresented: $showingEdit) {
                NavigationView {
                    ProfileEditor(profile: $draftProfile)
                        .navigationTitle("Edit user")
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    showingEdit = false
                                }
                            }

                            ToolbarItem(placement: .confirmationAction) {
                                Button("Done") {
                                    showingEdit = false
                                    modelData.updateProfile(profile: draftProfile)
                                }
                            }
                        }
                }
            }
        }
    }
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost()
            .environmentObject(ModelData())
    }
}
