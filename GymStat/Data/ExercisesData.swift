//
//  ExercisesData.swift
//  GymStat
//
//  Created by Lucas Morin on 09/10/2025.
//

import Foundation

struct ExercisesData{
    
    static let predefinedExercises: [Exercise] = [
        Exercise(name: "Pompes" , bodyPart: BodyPart(name: "Pec") ),
        Exercise(name: "Squats" , bodyPart: BodyPart(name: "Quadriceps")),
        Exercise(name: "Tractions", bodyPart: BodyPart(name: "Dos")),
        Exercise(name: "Fentes" , bodyPart: BodyPart(name: "Quadriceps")),
        Exercise(name: "Bench" , bodyPart: BodyPart(name: "Pec"))
        
    ]
}
