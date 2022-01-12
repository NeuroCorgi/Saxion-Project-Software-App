//
//  VaultRow.swift
//  Fort Knocks
//
//  Created by Aleksandr Pokatilov on 23.11.2021.
//

import SwiftUI

struct VaultRow: View {
    var vault: Profile.UserVault
    
    var body: some View {
        HStack {
            
            Text(vault.name)
            
            Spacer()
            
            if vault.awaits_approve {
                Image(systemName: "exclamationmark.circle")
                    .foregroundColor(.red)
            }
        }
        .frame(height: 40)
        .padding()
    }
}

struct VaultRow_Previews: PreviewProvider {
    static var previews: some View {
        VaultRow(vault: Profile.UserVault(id: 0, name: "0", awaits_approve: false))
    }
}
