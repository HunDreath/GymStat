//
//  AddExerciseView.swift
//  GymStat
//
//  Created by Lucas Morin on 09/10/2025.
//

import SwiftUI

struct AddExerciseView: View {
    
    @Binding var workoutExercises: [WorkoutExercise]
    @State private var selectedExercise: Exercise?
    @State private var showingCreateExercise = false
    
    @EnvironmentObject var exerciseService: ExerciseService
    
    var allExercises: [Exercise] {
        ExercisesData.predefinedExercises + exerciseService.customExercises
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Exercices proposés")) {
                    ForEach(ExercisesData.predefinedExercises) { exo in
                        Button(exo.name) {
                            addExercise(exo)
                        }
                    }
                }
                
                Section(header: Text("Mes exercices")) {
                    if exerciseService.customExercises.isEmpty {
                        Text("Aucun exercice créé")
                            .foregroundColor(.secondary)
                    } else {
                        ForEach(exerciseService.customExercises) { exo in
                            Button(exo.name) {
                                addExercise(exo)
                            }
                        }
                        .onDelete(perform: deleteExercise)
                    }
                }
            }
            .navigationTitle("Ajouter un exercice")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Créer") {
                        showingCreateExercise = true
                    }
                }
            }
            .sheet(isPresented: $showingCreateExercise) {
                CreateExerciseView() // ← plus besoin de binding
            }
        }
    }
    
    func addExercise(_ exercise: Exercise) {
        workoutExercises.append(WorkoutExercise(exercise: exercise, series: []))
    }
    
    func deleteExercise(at offsets: IndexSet) {
        exerciseService.deleteCustomExercise(at: offsets)
    }
}
