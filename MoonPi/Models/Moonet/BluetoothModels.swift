//
//  BluetoothModels.swift
//  MoonPi
//
//  Created by Gabriel Santos on 31/10/25.
//

final class BluetoothConnectRequest: Encodable {
    let mac: String?
    
    init(mac: String? = nil) {
        self.mac = mac
    }
}
