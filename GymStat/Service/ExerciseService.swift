//
//  ExerciseService.swift
//  GymStat
//
//  Created by Lucas Morin on 09/10/2025.
//

import Foundation

class ExerciseService: ObservableObject{
    
    @Published var customExercises: [Exercise] = []
    
    private let key = "customExercices"
    
    init(){
        loadCustomExercise()
    }
    
    func addCustomExercise(exercise: Exercise){
        customExercises.append(exercise)
        saveCustomExercise()
    }
    
    func deleteCustomExercise(at offsets: IndexSet){
        customExercises.remove(atOffsets: offsets)
        saveCustomExercise()
    }
    
    func saveCustomExercise(){
        if let data = try? JSONEncoder().encode(customExercises){
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    func loadCustomExercise(){
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([Exercise].self, from: data) {
            customExercises = decoded
        }
    }
    
}
