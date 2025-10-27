//
//  ExerciseDetailView.swift
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
        VStack(spacing: 16) {
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(workoutExercise.series) { series in
                        HStack {
                            Text("\(series.reps) reps")
                                .font(.headline)
                            Spacer()
                            Text("\(series.weight, specifier: "%.1f") kg")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 2)
                    }
                    .onDelete(perform: deleteSeries)
                }
                .padding(.horizontal)
            }
            
            VStack(spacing: 12) {
                // --- Champs de saisie ---
                HStack {
                    TextField("Reps", text: $reps)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    
                    TextField("Poids (kg)", text: $weight)
                        .keyboardType(.decimalPad)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                // --- Bouton Ajouter ---
                Button(action: addSeries) {
                    Text("Ajouter une série")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isAddButtonDisabled ? Color.gray.opacity(0.4) : Color.accentColor)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
                .disabled(isAddButtonDisabled)
            }
            .padding(.vertical)
        }
        .navigationTitle(workoutExercise.exercise.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // --- Validation bouton ---
    private var isAddButtonDisabled: Bool {
        Int(reps) == nil || Double(weight) == nil
    }
    
    // --- Ajouter série ---
    func addSeries() {
        guard let r = Int(reps), let w = Double(weight) else { return }
        let newSeries = Series(reps: r, weight: w)
        workoutExercise.series.append(newSeries)
        reps = ""
        weight = ""
    }
    
    // --- Supprimer série ---
    func deleteSeries(at offsets: IndexSet) {
        workoutExercise.series.remove(atOffsets: offsets)
    }
}

// MARK: - Preview

struct ExerciseDetailView_Previews: PreviewProvider {
    @State static var mockWorkoutExercise = WorkoutExercise(
        exercise: Exercise(name: "Développé couché", bodyPart: BodyPart(name: "Pectoraux")),
        series: [
            Series(reps: 10, weight: 60),
            Series(reps: 8, weight: 65)
        ]
    )
    
    static var previews: some View {
        NavigationView {
            ExerciseDetailView(workoutExercise: $mockWorkoutExercise)
        }
        .preferredColorScheme(.light)
        
        NavigationView {
            ExerciseDetailView(workoutExercise: $mockWorkoutExercise)
        }
        .preferredColorScheme(.dark)
    }
}
