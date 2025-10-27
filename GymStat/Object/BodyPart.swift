//
//  BodyPart.swift
//  GymStat
//
//  Created by Lucas Morin on 22/10/2025.
//

import Foundation

struct BodyPart: Codable, Identifiable, Hashable {
    var id = UUID()
    var name: String
}
