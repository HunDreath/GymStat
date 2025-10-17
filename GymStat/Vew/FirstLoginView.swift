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
            LinearGradient(gradient: Gradient(colors: [.purple, .blue]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                // Icône d'accueil
                Image(systemName: "figure.strengthtraining.traditional")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                    .padding(.top, 40)
                
                // Titre de bienvenue
                Text("Bienvenue sur **GymStat**")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                // Champ de texte pour prénom
                VStack(alignment: .leading, spacing: 10) {
                    Text("Ton prénom")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    TextField("Entre ton prénom", text: $prenom)
                        .padding()
                        .background(.white)
                        .cornerRadius(10)
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
                .disabled(prenom.isEmpty)
                .padding(.horizontal)
                
                Spacer()
            }
        }
    }
}

struct FirstLoginView_Previews: PreviewProvider {
    static var previews: some View {
        FirstLoginView()
            .environmentObject(UserService())
    }
}
