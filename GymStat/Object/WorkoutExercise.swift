//
//  WorkoutExercise.swift
//  GymStat
//
//  Created by Lucas Morin on 09/10/2025.
//

import Foundation

struct WorkoutExercise: Identifiable, Codable {
    
    let id = UUID()
    var exercise: Exercise
    var series: [Series]
    
}
