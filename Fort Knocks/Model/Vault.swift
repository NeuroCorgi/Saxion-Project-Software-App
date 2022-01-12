//
//  Vault.swift
//  Fort Knocks
//
//  Created by Aleksandr Pokatilov on 23.11.2021.
//

import Foundation
import CoreGraphics

struct Vault: Identifiable, Codable {
    var id: Int = 0
    var name: String = "V"
    var token: String = "t"
    var requires_2fa: Bool = false
    var awaits_approve: Bool = false
    var history: [OpeningLog] = []
    
    var auth_token: String?
    
    func authorise() {
        var components = URLComponents(string: "http://192.168.1.102:8000")!
        components.path = "/api/vault/confirm/\(auth_token!)/"
        var request = URLRequest(url: components.url!)
        request.setValue("Token 8f258d0e17cafaa8efc0353e9edb851b02adf85a", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { (data, response, _) in
            guard let data = data, let value = String(data: data, encoding: .utf8), let response = response else {
                return
            }
            print(response, value)
        }
        task.resume()
    }
        
    static let `default` = Vault()
}


struct OpeningLog: Identifiable {
    let id = UUID()
    let success: Bool
    let timeString: String
    var time: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: timeString)!
    }
}

extension OpeningLog: Codable {
    enum CodingKeys: String, CodingKey {
        case success
        case timeString = "time"
    }
}
