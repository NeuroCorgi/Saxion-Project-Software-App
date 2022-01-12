//
//  ProfileSummery.swift
//  Fort Knocks
//
//  Created by Aleksandr Pokatilov on 06.01.2022.
//

import SwiftUI

struct ProfileSummery: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        
    }
}

struct ProfileSummery_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSummery()
            .environmentObject(ModelData())
    }
}
