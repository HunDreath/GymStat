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
    @State private var searchText = ""
    
    @EnvironmentObject var exerciseService: ExerciseService
    @Environment(\.presentationMode) var presentationMode // ← pour fermer le modal
    
    var allExercises: [Exercise] {
        ExercisesData.predefinedExercises + exerciseService.customExercises
    }
    
    var filteredExercises: [Exercise] {
        if searchText.isEmpty {
            return allExercises
        } else {
            return allExercises.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredExercises, id: \.name) { exo in
                    Button {
                        addExercise(exo)
                    } label: {
                        HStack(alignment: .center, spacing: 12) {
                            // --- Icône du muscle ---
                            Image(systemName: icon(for: exo.bodyPart.name))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 32, height: 32)
                                .foregroundColor(.accentColor)
                                .padding(8)
                                .background(Color.accentColor.opacity(0.1))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                            // --- Nom et BodyPart ---
                            VStack(alignment: .leading, spacing: 4) {
                                Text(exo.name)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Text(exo.bodyPart.name)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 2)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(6)
                            }
                            
                            Spacer()
                            
                            // --- Badge pour custom exercise ---
                            if exerciseService.customExercises.contains(where: { $0.name == exo.name }) {
                                Text("Perso")
                                    .font(.caption2)
                                    .foregroundColor(.white)
                                    .padding(4)
                                    .background(Color.accentColor)
                                    .cornerRadius(6)
                            }
                        }
                        .padding(.vertical, 6)
                        .padding(.horizontal, 4)
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.03), radius: 2, x: 0, y: 1)
                    }
                }
                .onDelete(perform: deleteExercise)
            }
            .listStyle(.insetGrouped)
            .searchable(text: $searchText, prompt: "Rechercher un exercice")
            .navigationTitle("Ajouter un exercice")
            .toolbar {
                // --- Bouton Créer ---
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Créer") {
                        showingCreateExercise = true
                    }
                }
                
                // --- Bouton Fermer ---
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Fermer") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .sheet(isPresented: $showingCreateExercise) {
                CreateExerciseView()
                    .environmentObject(exerciseService)
                    .interactiveDismissDisabled(false)
            }
        }
    }
    
    // --- Ajouter exercice ---
    func addExercise(_ exercise: Exercise) {
        workoutExercises.append(WorkoutExercise(exercise: exercise, series: []))
    }
    
    // --- Supprimer exercice custom ---
    func deleteExercise(at offsets: IndexSet) {
        exerciseService.deleteCustomExercise(at: offsets)
    }
    
    // --- Choisir une icône en fonction du BodyPart ---
    func icon(for bodyPart: String) -> String {
        switch bodyPart.lowercased() {
        case "dos": return "figure.walk"
        case "biceps": return "hand.raised.fill"
        case "triceps": return "hand.raised"
        case "quadriceps": return "figure.stand"
        case "fessier": return "figure.wave"
        case "ischio": return "figure.run"
        case "pec": return "figure.flexibility"
        case "abdos": return "flame.fill"
        case "avant bras": return "hand.thumbsup.fill"
        default: return "questionmark.circle"
        }
    }
}

// MARK: - Preview

struct AddExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        let mockService = ExerciseService()
        let mockWorkoutExercises = Binding.constant([
            WorkoutExercise(exercise: Exercise(name: "Développé couché", bodyPart: BodyPart(name: "Pectoraux")), series: []),
            WorkoutExercise(exercise: Exercise(name: "Squat", bodyPart: BodyPart(name: "Quadriceps")), series: [])
        ])
        
        AddExerciseView(workoutExercises: mockWorkoutExercises)
            .environmentObject(mockService)
            .preferredColorScheme(.light)
        
        AddExerciseView(workoutExercises: mockWorkoutExercises)
            .environmentObject(mockService)
            .preferredColorScheme(.dark)
    }
}
