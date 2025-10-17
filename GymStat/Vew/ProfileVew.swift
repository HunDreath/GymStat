//
//  ProfileView.swift
//  GymStat
//
//  Created by Lucas Morin on 08/10/2025.
//

import SwiftUI

struct ProfileVew: View {
    
    @EnvironmentObject var userService: UserService
    @State private var isEditing = false
    @State private var editedName = ""
    
    let user: User
    
    var body: some View {
        ZStack {
            // Dégradé de fond
            LinearGradient(gradient: Gradient(colors: [.purple, .blue]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                if let user = userService.currentUser {
                    
                    // Icône de profil
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .foregroundColor(.white)
                        .padding(.top, 40)
                    
                    // Prénom affiché ou éditable
                    if isEditing {
                        TextField("Ton prénom", text: $editedName)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 3)
                            .padding(.horizontal)
                    } else {
                        Text(user.nickName)
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                    }
                    
                    Spacer()
                    
                    // Bouton modifier / enregistrer
                    Button(action: {
                        if isEditing {
                            var updatedUser = user
                            updatedUser.nickName = editedName
                            userService.saveUser(user: updatedUser)
                        } else {
                            editedName = user.nickName
                        }
                        isEditing.toggle()
                    }) {
                        Text(isEditing ? "Enregistrer" : "Modifier mes infos")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(isEditing ? Color.green : Color.white.opacity(0.8))
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                } else {
                    Text("Aucun utilisateur connecté.")
                        .foregroundColor(.white.opacity(0.7))
                }
            }
        }
    }
}

struct ProfileVew_Previews: PreviewProvider {
    static var previews: some View {
        ProfileVew(user: User(nickName: "GymStat"))
        
    }
}
