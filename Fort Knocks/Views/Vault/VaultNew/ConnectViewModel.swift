//
//  ConnectViewModel.swift
//  Fort Knocks
//
//  Created by Aleksandr Pokatilov on 08.01.2022.
//

import CoreBluetooth
import Combine

final class ConnectViewModel: ObservableObject {
    static var common: ConnectViewModel = .init()
    
    @Published var isReady = false
    
    @Published var SSID: String = ""
    @Published var password: String = ""
     var token: String = ""
    
    private var request: APIRequest<TokenResource>?
    
    private enum Constants {
        static let readServiceUUID: CBUUID = .init(string: "FFD0")
        static let writeServiceUUID: CBUUID = .init(string: "FFD5")
        static let serviceUUIDs: [CBUUID] = [readServiceUUID, writeServiceUUID]
        static let readCharacteristicUUID: CBUUID = .init(string: "FFD4")
        static let writeCharacteristicUUID: CBUUID = .init(string: "FFD9")
    }
    
    private lazy var manager: BluetoothManager = .shared
    private lazy var cancellables: Set<AnyCancellable> = .init()

    var peripheral: CBPeripheral?
    private var readCharacteristic: CBCharacteristic?
    private var writeCharacteristic: CBCharacteristic?
    
    func setPeripheral(peripheral: CBPeripheral) {
        self.peripheral = peripheral
    }
    
    deinit {
        cancellables.removeAll()
    }
    
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
    
    func connect() {
        guard peripheral != nil else {
            return
        }
        
        manager.servicesSubject
            .map { $0.filter { Constants.serviceUUIDs.contains($0.uuid)} }
            .sink { [weak self] service in
                service.forEach { service in
                    self?.peripheral!.discoverCharacteristics(nil, for: service)
                }
            }
            .store(in: &cancellables)
        
        manager.charachteristicSubject
            .filter { $0.0.uuid == Constants.readServiceUUID }
            .compactMap { $0.1.first(where: \.uuid == Constants.readCharacteristicUUID) }
            .sink { [weak self] charachteristic in
                self?.readCharacteristic = charachteristic
                self?.toggle()
            }
            .store(in: &cancellables)
        
        manager.charachteristicSubject
            .filter { $0.0.uuid == Constants.writeServiceUUID }
            .compactMap { $0.1.first(where: \.uuid == Constants.writeCharacteristicUUID) }
            .sink { [weak self] charachteristic in
                self?.writeCharacteristic = charachteristic
                self?.toggle()
            }
            .store(in: &cancellables)
        
        manager.connect(peripheral!)
    }
    
    private func toggle() {
        guard writeCharacteristic != nil, readCharacteristic != nil else {
            return
        }
        isReady = true
    }
    
    func write() {
        guard let characteristic = writeCharacteristic, let peripheral = peripheral else {
            return
        }
        let data = "\(SSID):\(password):\(token)".data(using: .utf8)!
        print(peripheral)
        peripheral.writeValue(data, for: characteristic, type: .withResponse)
    }
}


func ==<Root, Value: Equatable>(lhs: KeyPath<Root, Value>, rhs: Value) -> (Root) -> Bool {
    { $0[keyPath: lhs] == rhs }
}

func ==<Root, Value: Equatable>(lhs: KeyPath<Root, Value>, rhs: Value?) -> (Root) -> Bool {
    { $0[keyPath: lhs] == rhs }
}
