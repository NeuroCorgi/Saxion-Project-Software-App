//
//  VaultList.swift
//  Fort Knocks
//
//  Created by Aleksandr Pokatilov on 23.11.2021.
//

import SwiftUI

struct VaultList: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showingAddView = false

    var body: some View {
        NavigationView {
            List {
                ForEach(modelData.profile.vaults) { vault in
                    NavigationLink {
                        VaultDetailed(id: vault.id)
                    } label: {
                        VaultRow(vault: vault)
                    }
                }
            }
            .navigationTitle("Your vaults")
            .toolbar {
                Button {
                    showingAddView = true
                } label: {
                    Image(systemName: "plus")
                }

            }
            .refreshable {
                modelData.loadProfile()
            }
            .sheet(isPresented: $showingAddView) {
                NavigationView {
                    NewVaultView(presentationMode: $showingAddView)
                        .navigationTitle("New vault")
                        .onDisappear(perform: {
                            VaultNewViewModel.common = .init()
                            ConnectViewModel.common = .init()
                        })
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    showingAddView = false
                                }
                            }
                        }
                }
            }
        }
        .onAppear {
            modelData.loadProfile()
        }
    }
}

struct VaultList_Previews: PreviewProvider {
    static var previews: some View {
        VaultList()
            .environmentObject(ModelData())
    }
}
