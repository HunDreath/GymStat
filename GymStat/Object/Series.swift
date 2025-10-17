//
//  Series.swift
//  GymStat
//
//  Created by Lucas Morin on 09/10/2025.
//

import Foundation

struct Series: Identifiable, Codable {
    
    let id = UUID()
    var reps: Int
    var weight: Double
    
}
