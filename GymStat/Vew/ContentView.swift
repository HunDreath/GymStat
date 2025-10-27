import SwiftUI

struct ContentView: View {
    
    @StateObject var userService = UserService()
    @StateObject var exerciseService = ExerciseService()
    
    var body: some View {
        Group {
            if userService.currentUser != nil {
                MainTabView()
                    .environmentObject(userService)
                    .environmentObject(exerciseService)
            } else {
                FirstLoginView()
                    .environmentObject(userService)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let mockUserService = UserService()
        mockUserService.currentUser = User(nickName: "GymStat")
        let mockExerciseService = ExerciseService()
        
        return Group { 
            ContentView()
                .environmentObject(mockUserService)
                .environmentObject(mockExerciseService)
        }
    }
}
