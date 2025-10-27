import SwiftUI

struct NewSessionView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var sessionName: String = ""
    @State private var workoutExercises: [WorkoutExercise] = [] // <-- plus de Binding
    
    @State private var showingAddExercise = false
    
    var body: some View {
        NavigationView {
            VStack {
                // --- Champ pour le nom de la séance ---
                TextField("Nom de la séance", text: $sessionName)
                    .font(.title2)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                
                // --- Liste des exercices ---
                List {
                    ForEach($workoutExercises) { $workoutExercise in
                        NavigationLink(destination: ExerciseDetailView(workoutExercise: $workoutExercise)) {
                            HStack {
                                Text(workoutExercise.exercise.name)
                                    .font(.headline)
                                Spacer()
                                Text(workoutExercise.exercise.bodyPart.name)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .padding(4)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(6)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .onDelete { indexSet in
                        workoutExercises.remove(atOffsets: indexSet)
                    }
                }
                .listStyle(.insetGrouped)
                
                // --- Bouton ajouter exercice ---
                Button(action: { showingAddExercise = true }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Ajouter un exercice")
                            .fontWeight(.semibold)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor.opacity(0.1))
                    .foregroundColor(.accentColor)
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
                .sheet(isPresented: $showingAddExercise) {
                    AddExerciseView(workoutExercises: $workoutExercises)
                        .environmentObject(ExerciseService())
                }
                
                Spacer()
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
                    .disabled(workoutExercises.isEmpty || sessionName.isEmpty)
                }
            }
        }
    }
    
    func saveSession() {
        print("Séance enregistrée :", sessionName, workoutExercises)
    }
}

// MARK: - Preview

struct NewSessionView_Previews: PreviewProvider {
    static var previews: some View {
        NewSessionView()
            .preferredColorScheme(.light)
        
        NewSessionView()
            .preferredColorScheme(.dark)
    }
}
