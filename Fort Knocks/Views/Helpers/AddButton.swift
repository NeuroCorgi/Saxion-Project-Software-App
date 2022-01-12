//
//  AddButton.swift
//  Fort Knocks
//
//  Created by Aleksandr Pokatilov on 23.11.2021.
//

import SwiftUI

struct AddButton: View {
    
    private let size = 40
    
    var body: some View {
        Button {
            
        } label: {
            ZStack {
                Circle()
                    .size(CoreGraphics.CGSize(width: 40, height: 30))
                    .scaledToFill()
                    .foregroundColor(.blue)
                
                Text("Add")
                    .foregroundColor(.white)
                    .font(.caption)
            }
        }
    }
}

struct AddButton_Previews: PreviewProvider {
    static var previews: some View {
        AddButton()
    }
}
