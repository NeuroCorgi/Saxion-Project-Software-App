//
//  BluetoothManager.swift
//  Fort Knocks
//
//  Created by Aleksandr Pokatilov on 08.01.2022.
//

import Combine
import CoreBluetooth


final class BluetoothManager: NSObject {
    static let shared: BluetoothManager = .init()
    
    var stateSubject: PassthroughSubject<CBManagerState, Never> = .init()
    var peripheralSubject: PassthroughSubject<CBPeripheral, Never> = .init()
    var servicesSubject: PassthroughSubject<[CBService], Never> = .init()
    var charachteristicSubject: PassthroughSubject<(CBService, [CBCharacteristic]), Never> = .init()
    
    private var centralManager: CBCentralManager!
    
    func start() {
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func scan() {
        centralManager.scanForPeripherals(withServices: nil)
    }
    
    func connect(_ peripheral: CBPeripheral) {
        centralManager.stopScan()
        peripheral.delegate = self
        centralManager.connect(peripheral)
    }
}

extension BluetoothManager: CBCentralManagerDelegate {
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        stateSubject.send(central.state)
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        peripheralSubject.send(peripheral)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.discoverServices(nil)
    }
    
}

extension BluetoothManager: CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else {
            return
        }
        servicesSubject.send(services)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let charachteristics = service.characteristics else {
            return
        }
        charachteristicSubject.send((service, charachteristics))
    }
}
