//
//  Network.swift
//  Fort Knocks
//
//  Created by Aleksandr Pokatilov on 05.01.2022.
//

import Foundation
import SwiftUI

protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func decode(_ data: Data) -> ModelType?
    func execute(withCompletion completion: @escaping (ModelType?) -> Void)
}

extension NetworkRequest {
    fileprivate func get(_ url: URL, withCompletion completion: @escaping (ModelType?) -> Void) {
        var request = URLRequest(url: url)
        request.setValue("Token 8f258d0e17cafaa8efc0353e9edb851b02adf85a", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) { [weak self] (data, _ , error) -> Void in
            guard let data = data, let value = self?.decode(data), error == nil else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            DispatchQueue.main.async { completion(value) }
        }
        task.resume()
    }
    fileprivate func put(_ url: URL, body: Data?, withCompletion completion: @escaping (ModelType?) -> Void) {
        var request = URLRequest(url: url)
        request.setValue("Token 8f258d0e17cafaa8efc0353e9edb851b02adf85a", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT"
        request.httpBody = body
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) -> Void  in
            guard let data = data, let value = self.decode(data), error == nil else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            DispatchQueue.main.async { completion(value) }
        }
        task.resume()
    }
}

class APIRequest<Resource: APIResource> {
    let resource: Resource
    
    init(_ resource: Resource) {
        self.resource = resource
    }
}

extension APIRequest: NetworkRequest {
    func decode(_ data: Data) -> Resource.ModelType? {
        let obj = try? JSONDecoder().decode(Resource.ModelType.self, from: data)
        return obj
    }
    
    func execute(withCompletion completion: @escaping (Resource.ModelType?) -> Void) {
        get(resource.url, withCompletion: completion)
    }
    
    func execute(_ data: Resource.ModelType, withCompletion completion: @escaping (Resource.ModelType?) -> Void) {
        let data = try? JSONEncoder().encode(data)
        put(resource.url, body: data, withCompletion: completion)
    }
}
