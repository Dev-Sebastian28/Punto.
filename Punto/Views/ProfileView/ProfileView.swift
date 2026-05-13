import SwiftUI



// MARK: - MAIN VIEW
struct ProfileView: View {
    @Environment(AppCoordinator.self) var coordinator
    let user: User
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                header
                premiumCard
                
                // MARK: User Personal Information
                SectionView(
                    coordinator: coordinator.profileCoordinator,
                    title: "PERSONAL INFORMATION",
                    items: [
                        SectionItem(
                            icon: "person",
                            title: "Profile Details",
                            route: .profileDetails
                        ),
                        SectionItem(
                            icon: "lock",
                            title: "Security & Password",
                            route: .security
                        ),
                    ],
                )
                
                // MARK: Punto
                SectionView(
                    coordinator: coordinator.profileCoordinator,
                    title: "PUNTO",
                    items: [
                        SectionItem(
                            icon: "car",
                            title: "Vehicles Help Center",
                            route: .vehicleHelpCenter
                        ),
                        SectionItem(
                            icon: "person",
                            title: "Drivers Support",
                            route: .driverHelpCenter
                        ),
                        SectionItem(
                            icon: "doc.text",
                            title: "Cargo",
                            route: .cargoHelpCenter
                        )
                    ],
                )
                
                // MARK: Help Center
                SectionView(
                    coordinator: coordinator.profileCoordinator,
                    title: "SUPPORT & HELP",
                    items: [
                        SectionItem(
                            icon: "questionmark.circle",
                            title: "Help Center",
                            route: .vehicleHelpCenter
                        ),
                        SectionItem(
                            icon: "bubble.left",
                            title: "Contact Support",
                            route: .driverHelpCenter
                        ),
                        SectionItem(
                            icon: "doc.text",
                            title: "FAQ",
                            route: .faq
                        )
                    ],
                )
            }.padding(.vertical)
        }.background(Color(.systemGray6))
    }
    
    @ViewBuilder
    private var imageContent: some View {
        if let urlString = user.userInformation.avatar, let url = URL(string: urlString) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    placeholder
                        .overlay(ProgressView())
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure:
                    placeholder
                        .overlay {
                            Image(systemName: "photo.slash")
                                .foregroundStyle(.secondary)
                        }
                @unknown default:
                    Image(systemName: "person.crop.circle")
                }
            }
        } else {
            placeholder
                .overlay {
                    Image(systemName: "person.crop.circle")
                        .font(.largeTitle)
                }
        }
    }
    private var placeholder: some View {
        Circle()
            .foregroundStyle(.white)
            .frame(width: 100, height: 100)
    }
    
    // MARK: - HEADER
    var header: some View {
        VStack {
            imageContent
            
            Text(user.userInformation.fullName)
                .font(.title2)
                .fontWeight(.semibold)
            Text(user.userInformation.email)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
    
    // MARK: - PREMIUM CARD
    var premiumCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "crown.fill")
                Text("Premium Plan")
                    .font(.headline)
            }
            .foregroundColor(.white)
            
            Text("Unlock exclusive features and priority support")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.9))
            
            Button {
                coordinator.profileCoordinator.navigate(to: .subscription)
            } label: {
                Text("Manage Subscription")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.blue)
                    .cornerRadius(20)
            }
        }
        .padding()
        .background(
            LinearGradient(
                colors: [Color.black.opacity(0.2), Color.blue],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .cornerRadius(25)
        .padding(.horizontal)
    }
}

#Preview {
    ProfileView(user: .mock)
        .environment(AppCoordinator(appState: AppState()))
}
