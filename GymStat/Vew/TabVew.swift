import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    @State private var showingNewSession = false
    
    @EnvironmentObject var userService: UserService
    @EnvironmentObject var exerciseService: ExerciseService

    var body: some View {
        VStack(spacing: 0) {
            
            // --- Contenu selon l'onglet sélectionné ---
            Group {
                switch selectedTab {
                case 0:
                    HomeVew()
                        .environmentObject(exerciseService)
                        .environmentObject(userService)
                case 1:
                    ProfileView()
                        .environmentObject(userService)
                default:
                    HomeVew()
                        .environmentObject(exerciseService)
                        .environmentObject(userService)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // --- Barre d’onglets ---
            HStack {
                Spacer()
                Button(action: { selectedTab = 0 }) {
                    VStack {
                        Image(systemName: "house")
                        Text("Accueil")
                    }
                    .foregroundColor(selectedTab == 0 ? .purple : .gray)
                }
                Spacer()
                
                Button(action: { showingNewSession.toggle() }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.purple)
                        .shadow(radius: 5)
                }
                .offset(y: -20)
                Spacer()
                
                Button(action: { selectedTab = 1 }) {
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
                .environmentObject(exerciseService)
        }
    }
}

// MARK: - Preview

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        let mockUserService = UserService()
        mockUserService.currentUser = User(nickName: "GymStat") // utilisateur mock
        let mockExerciseService = ExerciseService()
        
        return MainTabView()
            .environmentObject(mockUserService)
            .environmentObject(mockExerciseService)
            .preferredColorScheme(.light)
    }
}
