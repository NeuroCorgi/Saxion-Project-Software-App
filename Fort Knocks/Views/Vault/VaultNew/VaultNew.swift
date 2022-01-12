//
//  VaultNew.swift
//  Fort Knocks
//
//  Created by Aleksandr Pokatilov on 07.01.2022.
//

import SwiftUI
import CoreBluetooth

struct NewVaultView: View {
    @StateObject private var viewModel: VaultNewViewModel = .common
    @StateObject private var connectModel: ConnectViewModel = .common
    @Binding var presentationMode: Bool
    @State private var index = 0;
    
    var body: some View {
        VStack {
            content()
            Spacer()
            Button(action: nextView) {
                NextButton(text: viewModel.buttonText, image: viewModel.buttonImage)
            }
            .disabled( viewModel.peripheral == nil )
        }
    }
    
    @ViewBuilder
    private func content() -> some View {
        if viewModel.state == .poweredOff {
            Text("Enable bluetooth to connect new vault")
        }
        else {
            switch index {
            case 0:
                InstructionView()
            case 1:
                WiFiDataView()
            case 2:
                ConnectView()
            default:
                Text("Hello World")
                    .onAppear {
                        presentationMode = false
                    }
            }
        }
    }
    
    private func nextView() {
        index += 1
    }
}

struct InstructionView: View {
    @StateObject private var viewModel: VaultNewViewModel = .common
    @StateObject private var connectModel: ConnectViewModel = .common
    
    var body: some View {
        VStack {
            Text("Set up")
                .font(.title)
            Divider()
            VStack(alignment: .leading) {
                Text("Power up your vault")
                Text("When the green light is on, enter password")
                Text("Press the next button below")
            }
            .padding()
        }
        .padding()
        .onAppear {
            viewModel.start()
        }
    }
}

struct WiFiDataView: View {
    @StateObject private var viewModel: VaultNewViewModel = .common
    @StateObject private var connectModel: ConnectViewModel = .common
    @State private var didAppear = false
    
    var body: some View {
        VStack {
            Text("WiFi data")
                .font(.title)
            Divider()
            VStack {
                TextField("SSID", text: $connectModel.SSID)
                SecureField("Password", text: $connectModel.password)
            }
            .padding()
        }
        .padding()
        .onAppear {
            guard didAppear == false else {
                return
            }
            connectModel.setPeripheral(peripheral: viewModel.peripheral!)
            connectModel.connect()
            connectModel.getToken()
        }
    }
}

struct ConnectView: View {
    @StateObject private var viewModel: VaultNewViewModel = .common
    @StateObject private var connectModel: ConnectViewModel = .common

    var body: some View {
        VStack {
            
        }
        .onAppear {
            print(connectModel.peripheral)
            print(connectModel.token)
            print(connectModel.isReady)
            connectModel.write()
        }
        .onDisappear {
            print(connectModel.isReady)
        }
    }
}

struct VaultNew_Previews: PreviewProvider {
    static var previews: some View {
        NewVaultView(presentationMode: .constant(true))
    }
}
