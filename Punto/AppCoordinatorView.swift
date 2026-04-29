struct AppCoordinatorView: View {
    var coordinator: AppCoordinator
    
    var body: some View {
        Group {
            switch coordinator.currentRoot {
            case .auth:
                // Cargamos el NavigationStack del flujo de Auth
                NavigationStack(path: Bindable(coordinator.authCoordinator).path) {
                    coordinator.authCoordinator.build(.login)
                        .navigationDestination(for: AutAuthFlow.self) { screen in
                            coordinator.authCoordinator.build(screen)
                        }
                }
                
            case .mainTabs:
                // Aquí iría tu TabView con los otros coordinadores (Mantenimiento, Flota, etc.)
                MainTabView(appCoordinator: coordinator)
                
            case .onboarding:
                // Flujo inicial para nuevos usuarios
                OnboardingView(coordinator: coordinator.onBoardingCoordinator)
            }
        }
    }
}