import SwiftUI

struct HomeVew: View {
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                // 1. Bienvenue
                VStack(alignment: .leading, spacing: 5) {
                    Text("Bonjour, Lucas 👋")
                        .font(.largeTitle)
                        .bold()
                    Text("Prêt pour ton entraînement ?")
                        .foregroundColor(.gray)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // 2. Statistiques rapides
                HStack(spacing: 15) {
                    StatCard(title: "Séances ce mois", value: "8")
                    StatCard(title: "Calories brûlées", value: "2,300 kcal")
                    StatCard(title: "Objectifs atteints", value: "3/5")
                }
                .padding(.horizontal)
                
                // 3. Prochaine séance
                VStack(alignment: .leading, spacing: 10) {
                    Text("Prochaine séance")
                        .font(.headline)
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Full Body")
                                .bold()
                            Text("Demain à 18h")
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Button(action: {
                            print("Commencer séance")
                        }) {
                            Text("Commencer")
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .background(Color.purple)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(15)
                }
                .padding(.horizontal)
                
                // 4. Citation motivante
                VStack {
                    Text("“Ne rêve pas de succès. Travaille pour l’atteindre ! 💪”")
                        .italic()
                        .foregroundColor(.purple)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(15)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top)
        }
    }
}

// Composant réutilisable pour les stats
struct StatCard: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack {
            Text(value)
                .font(.title2)
                .bold()
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(width: 100, height: 80)
        .background(Color(.systemGray6))
        .cornerRadius(15)
    }
}

struct HomeVew_Previews: PreviewProvider {
    static var previews: some View {
        HomeVew()
            .preferredColorScheme(.light)
        HomeVew()
            .preferredColorScheme(.dark)
    }
}
