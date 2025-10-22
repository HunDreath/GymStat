//
//  User.swift
//  GymStat
//
//  Created by Lucas Morin on 08/10/2025.
//

import SwiftUI
import Foundation

struct User: Codable , Identifiable{
    
    let id = UUID()
    var nickName: String
    
}


