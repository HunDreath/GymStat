//
//  FirstLoginView.swift
//  GymStat
//
//  Created by Lucas Morin on 08/10/2025.
//

import SwiftUI

struct FirstLoginView: View {
    
    @State private var prenom = ""
    @EnvironmentObject var userManager: UserService
    
    var body: some View {
        ZStack {
            // Dégradé de fond
            LinearGradient(gradient: Gradient(colors: [.purple, .blue, .pink]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                // Icône d'accueil
                Image(systemName: "dumbbell.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(LinearGradient(
                        gradient: Gradient(colors: [.orange , .red]),
                        startPoint: .top,
                        endPoint: .bottom))
                    .rotationEffect(.degrees(prenom.isEmpty ? 0 : 10))
                    .animation(.easeInOut(duration: 0.3), value: prenom)
                
                // Titre de bienvenue
                Text("Bienvenue sur **GymStat**")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                // Champ de texte pour prénom
                VStack(alignment: .leading, spacing: 10) {
                    
                    TextField("Entre ton prénom", text: $prenom)
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(12)
                        .shadow(radius: 3)
                }
                .padding(.horizontal)
                
                // Bouton de validation
                Button(action: {
                    let newUser = User(nickName: prenom)
                    userManager.saveUser(user: newUser)
                }) {
                    Text("Commencer")
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(prenom.isEmpty ? Color.gray : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .animation(.easeInOut(duration: 0.2 ), value : prenom)
                .disabled(prenom.isEmpty)
                .padding(.horizontal)
                
                Spacer()
            }
        }
    }
}

// Preview
struct FirstLoginView_Previews: PreviewProvider {
    static var previews: some View {
        FirstLoginView()
            .environmentObject(UserService(forPreview: true))
    }
}
