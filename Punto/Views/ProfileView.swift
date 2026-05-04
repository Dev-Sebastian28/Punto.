import SwiftUI

// MARK: - ROUTES
enum ProfileRoute: Hashable {
    case profileDetails
    case security
    case linkedAccounts
    case helpCenter
    case contactSupport
    case faq
    case subscription
}

// MARK: - MAIN VIEW
struct ProfileView: View {
    @State private var path: [ProfileRoute] = []
    let user: User
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                VStack(spacing: 20) {
                    
                    header
                    
                    premiumCard
                    
                    SectionView(
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
                            SectionItem(
                                icon: "link",
                                title: "Linked Accounts",
                                route: .linkedAccounts
                            )
                        ],
                        path: $path
                    )
                    
                    SectionView(
                        title: "PUNTO",
                        items: [
                            SectionItem(
                                icon: "car",
                                title: "Vehicles Help Center",
                                route: .helpCenter
                            ),
                            SectionItem(
                                icon: "person",
                                title: "Drivers Support",
                                route: .contactSupport
                            ),
                            SectionItem(
                                icon: "doc.text",
                                title: "Cargo",
                                route: .faq
                            )
                        ],
                        path: $path
                    )
                    
                    SectionView(
                        title: "SUPPORT & HELP",
                        items: [
                            SectionItem(
                                icon: "questionmark.circle",
                                title: "Help Center",
                                route: .helpCenter
                            ),
                            SectionItem(
                                icon: "bubble.left",
                                title: "Contact Support",
                                route: .contactSupport
                            ),
                            SectionItem(
                                icon: "doc.text",
                                title: "FAQ",
                                route: .faq
                            )
                        ],
                        path: $path
                    )
                }
                .padding(.vertical)
            }
            .background(Color(.systemGray6))
            .navigationDestination(for: ProfileRoute.self) { route in
                switch route {
                case .profileDetails:
                    Text("Profile Details View")
                case .security:
                    Text("Security & Password View")
                case .linkedAccounts:
                    Text("Linked Accounts View")
                case .helpCenter:
                    Text("Help Center View")
                case .contactSupport:
                    Text("Contact Support View")
                case .faq:
                    Text("FAQ View")
                case .subscription:
                    Text("Manage Subscription View")
                }
            }
        }
    }
    
    // MARK: - HEADER
    var header: some View {
        VStack(spacing: 5) {
            Circle()
                .stroke(Color.blue.opacity(0.5), lineWidth: 2)
                .frame(width: 80, height: 80)
                .overlay(
                    Image(systemName: "person")
                )
            
            Text(user.userInformation.name)
                .font(.title2)
                .fontWeight(.semibold)
            Text(user.email ?? "")
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
            
            NavigationLink(value: ProfileRoute.subscription) {
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

// MARK: - SECTION ITEM MODEL
struct SectionItem: Hashable {
    let icon: String
    let title: String
    let route: ProfileRoute
}

// MARK: - SECTION VIEW
struct SectionView: View {
    
    var title: String
    var items: [SectionItem]
    @Binding var path: [ProfileRoute]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.horizontal)
            
            VStack(spacing: 0) {
                ForEach(items, id: \.self) { item in
                    NavigationLink(value: item.route) {
                        HStack {
                            Image(systemName: item.icon)
                            Text(item.title)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .padding()
                    }.buttonStyle(.plain)
                    
                    if item != items.last {
                        Divider()
                    }
                }
            }
            .background(Color.white)
            .cornerRadius(15)
            .padding(.horizontal)
        }
    }
}

#Preview {
    ProfileView(user: .mock)
}
