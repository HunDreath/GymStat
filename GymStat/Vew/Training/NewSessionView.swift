//
//  NewSessionView.swift
//  GymStat
//
//  Created by Lucas Morin on 09/10/2025.
//

import SwiftUI

struct NewSessionView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var workoutExercises: [WorkoutExercise] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach($workoutExercises) { $workoutExercise in
                    NavigationLink(destination: ExerciseDetailView(workoutExercise: $workoutExercise)) {
                        Text(workoutExercise.exercise.name)
                    }
                }
                .onDelete { indexSet in
                    workoutExercises.remove(atOffsets: indexSet)
                }
            }
            .navigationTitle("Nouvelle séance")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Annuler") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Enregistrer") {
                        saveSession()
                        presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(workoutExercises.isEmpty)
                }
                ToolbarItem(placement: .bottomBar) {
                    NavigationLink("Ajouter exercice") {
                        AddExerciseView(workoutExercises: $workoutExercises)
                    }
                }
            }
        }
    }
    
    func saveSession() {
        // TODO : Sauvegarder la séance (UserDefaults, CoreData, fichier, etc.)
        print("Séance enregistrée :", workoutExercises)
    }
}

