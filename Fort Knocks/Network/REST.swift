//
//  REST.swift
//  Fort Knocks
//
//  Created by Aleksandr Pokatilov on 05.01.2022.
//

import Foundation

protocol APIResource {
    associatedtype ModelType: Codable
    var methodPath: String { get }
}

extension APIResource {
    var url: URL {
        var components = URLComponents(string: "http://192.168.1.102:8000")!
        components.path = "/api" + methodPath
        components.queryItems = [
            URLQueryItem(name: "format", value: "json")
        ]
        
        return components.url!
    }
}

struct ProfileResource: APIResource {
    typealias ModelType = Profile
    var id: Int?
    var methodPath: String {
        guard let id = id else {
            return "/user/0/"
        }
        return "/user/\(id)/"
    }
}

struct VaultResource: APIResource {
    typealias ModelType = Vault
    var id: Int?
    var methodPath: String {
        guard let id = id else {
            return "/vault/"
        }
        return "/vault/\(id)/"
    }
}

struct Token: Codable {
    var token: String
}

struct TokenResource: APIResource {
    typealias ModelType = Token
    var methodPath: String {
        "/vault/register/"
    }
}
