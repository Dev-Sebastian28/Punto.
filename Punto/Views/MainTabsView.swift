import SwiftUI

struct MainTabsView: View {
    let user: User
    @Environment(AppCoordinator.self) var coordinator
    
    var body: some View {
        TabView {
            Tab("Cargos", systemImage: "shippingbox.fill") {
                NavigationStack(path: Bindable(coordinator.cargoCoordinator).path) {
                    coordinator.cargoCoordinator.build(path: .main)
                        .navigationDestination(for: CargoRoute.self) { scren in
                            coordinator.cargoCoordinator.build(path: scren)
                        }
                }
            }
            
            
            TabSection {
                Tab("Expenses", systemImage: "banknote.fill") {
                    MonthlyExpensesView()
                }
                
                Tab("Fleet", systemImage: "truck.box.fill") {
                    NavigationStack(path: Bindable(coordinator.fleetCoordinator).path) {
                        coordinator.fleetCoordinator.build(route: .fleet)
                            .navigationDestination(for: FleetRoute.self) { scren in
                                coordinator.fleetCoordinator.build(route: scren)
                            }
                    }
                }
                
                Tab("Account", systemImage: "person.crop.circle.fill") {
                    ProfileView(user: user)
                }
            }
        }
    }
}

#Preview {
    let user = User.mock
    MainTabsView(user: user)
        .environment(AppCoordinator(appState: AppState()))
        .environment(CarouselViewModel(user: user))
}
