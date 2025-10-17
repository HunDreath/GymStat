//
//  HomeVew.swift
//  GymStat
//
//  Created by Lucas Morin on 08/10/2025.
//

import SwiftUI

struct HomeVew: View {
    
    let user: User
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct HomeVew_Previews: PreviewProvider {
    static var previews: some View {
        HomeVew(user: User(nickName: "GymStat"))
    }
}
