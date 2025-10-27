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
    @State private var selectedBodyPart: BodyPart? = nil
    @State private var customBodyPartName = ""
    @State private var showBodyPartSelector = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                
                // --- Section: Infos de l'exercice ---
                VStack(alignment: .leading, spacing: 16) {
                    
                    Text("Nom de l’exercice")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    TextField("Ex: Développé couché", text: $exerciseName)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 2)
                    
                    Text("Zone de travail")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    
                    // --- Bouton ouvrant le sélecteur ---
                    Button(action: {
                        showBodyPartSelector = true
                    }) {
                        HStack {
                            Text(selectedBodyPart?.name ?? "Choisir une zone")
                                .foregroundColor(selectedBodyPart == nil ? .gray : .primary)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 2)
                    }
                }
                .padding(.horizontal)
                
                // --- Champ personnalisé si "Autre" ---
                if selectedBodyPart?.name == "Autre" {
                    TextField("Nom personnalisé", text: $customBodyPartName)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 2)
                        .padding(.horizontal)
                }
                
                Spacer()
                
                // --- Bouton Ajouter ---
                Button(action: addExercise) {
                    Text("Ajouter l’exercice")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(isAddButtonDisabled ? Color.gray.opacity(0.4) : Color.accentColor)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
                .disabled(isAddButtonDisabled)
                
                Button("Annuler") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.secondary)
                .padding(.bottom, 20)
            }
            .navigationTitle("Nouvel exercice")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showBodyPartSelector) {
                BodyPartSelectorView(selectedBodyPart: $selectedBodyPart)
                    .presentationDetents([.medium, .large])
            }
        }
    }
    
    // --- Validation & Ajout ---
    private var isAddButtonDisabled: Bool {
        exerciseName.isEmpty ||
        (selectedBodyPart == nil) ||
        (selectedBodyPart?.name == "Autre" && customBodyPartName.isEmpty)
    }
    
    private func addExercise() {
        let finalBodyPart: BodyPart
        if let selected = selectedBodyPart {
            if selected.name == "Autre" {
                finalBodyPart = BodyPart(name: customBodyPartName)
            } else {
                finalBodyPart = selected
            }
        } else {
            finalBodyPart = BodyPart(name: "Inconnu")
        }
        
        let newExercise = Exercise(name: exerciseName, bodyPart: finalBodyPart)
        exerciseService.addCustomExercise(exercise: newExercise)
        presentationMode.wrappedValue.dismiss()
    }
}

// MARK: - Vue du sélecteur avec recherche
struct BodyPartSelectorView: View {
    @Binding var selectedBodyPart: BodyPart?
    @Environment(\.dismiss) var dismiss
    
    @State private var searchText = ""
    
    var filteredBodyParts: [BodyPart] {
        if searchText.isEmpty {
            return BodyPartData.predefinedBodyPart
        } else {
            return BodyPartData.predefinedBodyPart.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredBodyParts, id: \.self) { part in
                    Button {
                        selectedBodyPart = part
                        dismiss()
                    } label: {
                        HStack {
                            Text(part.name)
                                .foregroundColor(.primary)
                            Spacer()
                            if selectedBodyPart?.name == part.name {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.accentColor)
                            }
                        }
                    }
                }
                
                Section {
                    Button {
                        selectedBodyPart = BodyPart(name: "Autre")
                        dismiss()
                    } label: {
                        Label("Autre...", systemImage: "plus.circle")
                            .foregroundColor(.accentColor)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Choisir une zone")
            .searchable(text: $searchText, prompt: "Rechercher une zone")
        }
    }
}

// MARK: - Preview
struct CreateExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        let mockService = ExerciseService()
        CreateExerciseView()
            .environmentObject(mockService)
    }
}
