//
//  Exercice.swift
//  GymStat
//
//  Created by Lucas Morin on 09/10/2025.
//

import Foundation

struct Exercise: Identifiable, Codable, Equatable {
    
    let id = UUID()
    var name: String
    var bodyPart: BodyPart
    
}
