//
//  VaultNewModel.swift
//  Fort Knocks
//
//  Created by Aleksandr Pokatilov on 08.01.2022.
//

import Foundation
import CoreBluetooth
import Combine


final class VaultNewViewModel: ObservableObject {
    static var common: VaultNewViewModel = .init()
    
    @Published var buttonText: String = "Next"
    @Published var buttonImage: String = "arrow.right"
    
    @Published var state: CBManagerState = .unknown {
        didSet {
            update(with: state)
        }
    }
    
    @Published var peripheral: CBPeripheral?
    
    private lazy var manager: BluetoothManager = .shared
    private lazy var cancellables: Set<AnyCancellable> = .init()

    deinit {
        cancellables.removeAll()
    }
    
    func start() {
        manager.stateSubject.sink { [weak self] state in
            self?.state = state
        }
        .store(in: &cancellables)
        manager.start()
    }
    
    private func update(with state: CBManagerState) {
        guard peripheral == nil else {
            return
        }
        guard state == .poweredOn else {
            return
        }
        manager.peripheralSubject
            .filter {
                guard let name = $0.name else {
                    return false
                }
                print(name)
                return name.starts(with: "Fort.Vault")
            }
            .sink { [weak self] in self?.peripheral = $0 }
            .store(in: &cancellables)
        manager.scan()
    }
}
