//
//  EcerciseDetailView.swift
//  GymStat
//
//  Created by Lucas Morin on 09/10/2025.
//

import SwiftUI

struct ExerciseDetailView: View {
    @Binding var workoutExercise: WorkoutExercise
    
    @State private var reps = ""
    @State private var weight = ""
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Séries")) {
                    ForEach(workoutExercise.series) { series in
                        Text("\(series.reps) reps à \(series.weight, specifier: "%.1f") kg")
                    }
                    .onDelete(perform: deleteSeries)
                }
            }
            
            Form {
                TextField("Nombre de reps", text: $reps)
                    .keyboardType(.numberPad)
                TextField("Poids (kg)", text: $weight)
                    .keyboardType(.decimalPad)
                
                Button("Ajouter une série") {
                    addSeries()
                }
                .disabled(Int(reps) == nil || Double(weight) == nil)
            }
            .padding()
        }
        .navigationTitle(workoutExercise.exercise.name)
    }
    
    func addSeries() {
        if let r = Int(reps), let w = Double(weight) {
            let newSeries = Series(reps: r, weight: w)
            workoutExercise.series.append(newSeries)
            reps = ""
            weight = ""
        }
    }
    
    func deleteSeries(at offsets: IndexSet) {
        workoutExercise.series.remove(atOffsets: offsets)
    }
}

