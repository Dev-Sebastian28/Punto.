import SwiftUI

struct ProfileView: View {
    var body: some View {
        ScrollView {
            ZStack(alignment: .top) {
                // 1. Fondo Azul del Encabezado
                Color.blue
                    .frame(height: 300)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // 2. Información de Perfil
                    VStack(spacing: 10) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.white.opacity(0.8))
                            .background(Circle().fill(Color.white.opacity(0.2)))
                        
                        Text("John Anderson")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                        
                        Text("Member since 2024")
                            .font(.subheadline)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 6)
                            .background(Capsule().fill(Color.white.opacity(0.2)))
                            .foregroundColor(.white)
                    }
                    .padding(.top, 40)
                    
                    // 3. Tarjeta Premium (Naranja)
                    PremiumCard()
                        .padding(.horizontal)
                    
                    // 4. Listas de Opciones
                    VStack(alignment: .leading, spacing: 25) {
                        MenuSection(title: "PERSONAL INFORMATION", items: [
                            MenuItem(icon: "person.circle", text: "Profile Details"),
                            MenuItem(icon: "lock", text: "Security & Password"),
                            MenuItem(icon: "link", text: "Linked Accounts")
                        ])
                        
                        MenuSection(title: "SUPPORT & HELP", items: [
                            MenuItem(icon: "questionmark.circle", text: "Help Center"),
                            MenuItem(icon: "bubble.left", text: "Contact Support"),
                            MenuItem(icon: "info.circle", text: "FAQ")
                        ])
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                }
            }
        }
        .background(Color(uiColor: .systemGroupedBackground))
    }
}

// MARK: - Componentes Secundarios

struct PremiumCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Image(systemName: "crown.fill")
                Text("Premium Plan")
                    .font(.headline)
            }
            .foregroundColor(.white)
            
            Text("Unlock exclusive features and priority support")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.9))
            
            Button(action: {}) {
                Text("Manage Subscription")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.orange)
                    .cornerRadius(12)
            }
        }
        .padding(25)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(LinearGradient(colors: [.orange, .red.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing))
        )
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
}

struct MenuSection: View {
    let title: String
    let items: [MenuItem]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.caption)
                .bold()
                .foregroundColor(.gray)
            
            VStack(spacing: 0) {
                ForEach(items.indices, id: \.self) { index in
                    HStack {
                        Image(systemName: items[index].icon)
                            .frame(width: 30)
                        Text(items[index].text)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    
                    if index != items.count - 1 {
                        Divider().padding(.leading, 50)
                    }
                }
            }
            .background(Color.white)
            .cornerRadius(15)
        }
    }
}

struct MenuItem {
    let icon: String
    let text: String
}

// MARK: - Preview
#Preview {
    ProfileView()
}