//
//  NextButton.swift
//  Fort Knocks
//
//  Created by Aleksandr Pokatilov on 07.01.2022.
//

import SwiftUI

struct NextButton: View {
    let text: String
    let image: String
    var body: some View {
        VStack {
            HStack {
                Text(text)
                Image(systemName: image)
            }
            .font(.title3)
            .foregroundColor(.white)
            .padding(10)
            .background {
                Rectangle()
                    .foregroundColor(.accentColor)
                    .cornerRadius(10)
            }
        }
    }
}

struct NextButton_Previews: PreviewProvider {
    static var previews: some View {
        NextButton(text: "Next", image: "arrow.right")
    }
}
