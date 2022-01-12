//
//  CreationData.swift
//  Fort Knocks
//
//  Created by Aleksandr Pokatilov on 07.01.2022.
//

import Foundation

final class CreationData: ObservableObject {
    @Published var SSID: String = ""
    @Published var password: String = ""
    @Published var token: String = ""
    
    private var request: APIRequest<TokenResource>?
    
    func getToken() {
        let resource = TokenResource()
        let request = APIRequest(resource)
        
        self.request = request
        request.execute { [weak self] token in
            if token == nil {
                debugPrint("Error")
            }
            else {
                self?.token = token!.token
            }
        }
        
    }
}
