//
//  Profile.swift
//  Fort Knocks
//
//  Created by Aleksandr Pokatilov on 23.11.2021.
//

import Foundation


struct Profile: Identifiable {
    var id: Int = 0
    var name: String = "A"
    var email: String = "a@a.a"
    var vaults: [UserVault] = []
    
    struct UserVault: Identifiable, Codable {
        var id: Int
        var name: String
        var awaits_approve: Bool
    }
    
    static var `default` = Profile()
}

extension Profile: Codable {
    enum CodingKeys: String, CodingKey {
        case id, email, vaults
        case name = "username"
    }
}
