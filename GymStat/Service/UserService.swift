//
//  UserService.swift
//  GymStat
//
//  Created by Lucas Morin on 08/10/2025.
//

import SwiftUI
import Foundation

class UserService: ObservableObject {
    
    @Published var currentUser: User? = nil
    
    private let userKey = "storedUser"
    
    init(){
        loadUser()
    }
    
    func saveUser(user: User){
        
        if let encoded = try? JSONEncoder().encode(user){
            UserDefaults.standard.set(encoded, forKey: userKey)
            currentUser = user
        }
        
    }
    
    func loadUser(){
        
        if let savedData = UserDefaults.standard.data(forKey: userKey),
           let decoded = try? JSONDecoder().decode(User.self, from: savedData){
            currentUser = decoded
        }
    }
    
    func resetUser(){
        UserDefaults.standard.removeObject(forKey: userKey)
        currentUser = nil
    }
    
}


