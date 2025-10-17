//
//  ContentView.swift
//  GymStat
//
//  Created by Lucas Morin on 08/10/2025.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var userService = UserService()
    @StateObject var exerciseService = ExerciseService()
    
    var body: some View {
        
        Group {
            
            if let user = userService.currentUser {
                TabVew(user: user)
                    .environmentObject(exerciseService)
            } else {
                FirstLoginView()
                    .environmentObject(userService)
            }
            
        }
        
    }
}
