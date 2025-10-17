//
//  TabVew.swift
//  GymStat
//
//  Created by Lucas Morin on 08/10/2025.
//

import SwiftUI

struct TabVew: View {
    @State private var selectedTab = 0
    @State private var showingNewSession = false
    let user: User

    var body: some View {
        VStack(spacing: 0) {
            // Affiche la vue selon l'onglet sélectionné
            Group {
                if selectedTab == 0 {
                    HomeVew(user: user)
                } else if selectedTab == 1 {
                    ProfileVew(user: user)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Barre d'onglets personnalisée
            HStack {
                Spacer()
                Button(action: {
                    selectedTab = 0
                }) {
                    VStack {
                        Image(systemName: "house")
                        Text("Accueil")
                    }
                    .foregroundColor(selectedTab == 0 ? .purple : .gray)
                }
                Spacer()
                
                Button(action: {
                    showingNewSession.toggle()
                }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.purple)
                        .shadow(radius: 5)
                }
                .offset(y: -20) // Pour que le bouton dépasse un peu la barre
                Spacer()
                
                Button(action: {
                    selectedTab = 1
                }) {
                    VStack {
                        Image(systemName: "person")
                        Text("Profil")
                    }
                    .foregroundColor(selectedTab == 1 ? .purple : .gray)
                }
                Spacer()
            }
            .padding(.top, 10)
            .padding(.bottom, 20)
            .background(Color(UIColor.systemBackground).shadow(radius: 2))
        }
        .edgesIgnoringSafeArea(.bottom)
        .sheet(isPresented: $showingNewSession) {
            NewSessionView()
        }
    }
}

