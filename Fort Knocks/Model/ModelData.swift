//
//  ModelData.swift
//  Fort Knocks
//
//  Created by Aleksandr Pokatilov on 23.11.2021.
//

import Foundation
import Combine
import SwiftUI

final class ModelData: ObservableObject {    
    @Published var profile: Profile = Profile.default
    @Published var vault: Vault = Vault.default
    @Published var isLoading = false
    
    private var profile_request: APIRequest<ProfileResource>?
    private var vault_request: APIRequest<VaultResource>?
    
    func loadProfile() {
        guard !isLoading else { return }
        isLoading = true
        
        let resource = ProfileResource()
        let request = APIRequest(resource)
        
        self.profile_request = request
        request.execute { [weak self] profile in
            if profile == nil {
                self?.profile = Profile.default
            }
            else {
                self?.profile = profile!
            }
            self?.isLoading = false
        }
    }
    
    func updateProfile(profile: Profile) {
        guard !isLoading else { return }
        isLoading = true
        
        let resource = ProfileResource(id: profile.id)
        let request = APIRequest(resource)
        
        self.profile_request = request
        request.execute(profile) { [weak self] profile in
            self?.isLoading = false
        }
        self.profile = profile
    }
    
    func loadVault(id: Int) {
        guard !isLoading else { return  }
        isLoading = true
        
        let resource = VaultResource(id: id)
        let request = APIRequest(resource)
        
        self.vault_request = request
        request.execute { [weak self] vault in
            if vault != nil {
                self?.isLoading = false
                self?.vault = vault!
                print(self?.vault.history)
            }
            self?.isLoading = false
        }
    }
    
    func updateVault(vault: Vault) {
        guard !isLoading else { return  }
        isLoading = true
        
        let resource = VaultResource(id: vault.id)
        let request = APIRequest(resource)
        
        self.vault_request = request
        request.execute(vault) { [weak self] vault in
            self?.isLoading = false
        }
        self.vault = vault
    }
}
