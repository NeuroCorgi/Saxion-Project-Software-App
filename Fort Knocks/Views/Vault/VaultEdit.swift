//
//  VaultEdit.swift
//  Fort Knocks
//
//  Created by Aleksandr Pokatilov on 07.01.2022.
//

import SwiftUI

struct VaultEdit: View {
    @Binding var vault: Vault
    
    var body: some View {
        List {
            TextField("Vault name", text: $vault.name)
                
        }
    }
}

struct VaultEdit_Previews: PreviewProvider {
    static var previews: some View {
        VaultEdit(vault: .constant(Vault()))
    }
}
