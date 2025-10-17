//
//  CreateExerciceView.swift
//  GymStat
//
//  Created by Lucas Morin on 09/10/2025.
//

import SwiftUI

struct CreateExerciseView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var exerciseService: ExerciseService
    
    @State private var exerciseName = ""
    @State private var bodyPartName = ""
    
    var body: some View {
        
        NavigationView {
            Form {
                TextField("Nom de l'exercice" , text: $exerciseName)
                    .padding()
                TextField("Zone de travail" ,text: $bodyPartName)
            }
            .navigationTitle("Nouvel exercice")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Ajouter") {
                        let exerciseBodyPart = BodyPart(name: bodyPartName)
                        let newExercise = Exercise(name: exerciseName , bodyPart: exerciseBodyPart )
                        exerciseService.addCustomExercise(exercise: newExercise)
                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(exerciseName.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annuler") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

