//
//  VaultDetailed.swift
//  Fort Knocks
//
//  Created by Aleksandr Pokatilov on 23.11.2021.
//

import SwiftUI

struct VaultDetailed: View {
    @EnvironmentObject var modelData: ModelData
    @State private var filter = false
    @State private var showingEdit = false
    @State private var draftVault = Vault()
    var id: Int
    
    var body: some View {
        VStack {
            Text(modelData.vault.name)
                .font(.title)
            
            List {
                Section("Two-factor authentication") {
                    Toggle("Two factor authentication", isOn: $modelData.vault.requires_2fa)
                    HStack {
                        Text("Confirm opening")
                        Spacer()
                        Button("open") {
                            modelData.vault.authorise()
                            modelData.loadVault(id: id)
                        }
                        .disabled(!modelData.vault.awaits_approve)
                    }
                }
                
                Section(header: Text("History"), footer: Text("Last 10 times")) {
                    Toggle("Show only failed attempts", isOn: $filter)
                    ForEach(
                        modelData.vault.history.reversed().prefix(10).filter({ log in !filter || log.success == false })
                    ) { log in
                        HStack {
                            Text(log.timeString)
                            Spacer()
                            Text(log.success ? "Opened" : "Wrong password")
                                .foregroundColor(log.success ? .accentColor : .red)
                        }
                    }
                }
            }
            
        }
        .onAppear {
            modelData.loadVault(id: id)
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Edit") {
                    showingEdit = true
                    draftVault = modelData.vault
                }
            }
        }
        .sheet(isPresented: $showingEdit) {
            NavigationView {
                VaultEdit(vault: $draftVault)
                    .navigationTitle("Edit vault")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                showingEdit = false
                            }
                        }

                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                showingEdit = false
                            }
                        }
                    }
            }
        }

        
    }
}

struct VaultDetailed_Previews: PreviewProvider {
    static var previews: some View {
        VaultDetailed(id: 1)
    }
}
