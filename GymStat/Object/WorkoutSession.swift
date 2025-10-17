//
//  WorkoutSession.swift
//  GymStat
//
//  Created by Lucas Morin on 09/10/2025.
//

import Foundation

struct WorkoutSession: Identifiable, Codable {
    
    let id = UUID()
    var date: Date
    var exercises: [WorkoutExercise]
    
}
