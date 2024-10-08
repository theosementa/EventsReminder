//
//  NavigationManager.swift
//  Krabs
//
//  Created by Theo Sementa on 29/11/2023.
//

import SwiftUI

class NavigationManager: Router {

    // push
    func pushHome() {
        navigateTo(.home)
    }
    
    func pushEventDetail(event: EventEntity) {
        navigateTo(.eventDetail(event: event))
    }
    
    func pushSettings() {
        navigateTo(.settings)
    }
    
    // sheet
    func presentOnboarding(dismissAction: (() -> Void)? = nil) {
        presentSheet(.onboarding, dismissAction)
    }
    
    func presentCreateNewEvent(event: EventEntity? = nil, dismissAction: (() -> Void)? = nil) {
        presentSheet(.createNewEvent(event: event), dismissAction)
    }
    

    // Build view
    override func view(direction: NavigationDirection, route: Route) -> AnyView {
        AnyView(buildView(direction: direction, route: route))
    }
}

private extension NavigationManager {

    @ViewBuilder
    func buildView(direction: NavigationDirection, route: Route) -> some View {
        Group {
            switch direction {
            case .onboarding:
                OnboardingView()
            case .home:
                HomeView(router: router(route: route))
            case .settings:
                SettingsView()
            case .createNewEvent(let event):
                CreateNewEventView(event: event)
            case .eventDetail(let event):
                EventDetailView(router: router(route: route), event: event)
            }
        }
    }

    func router(route: Route) -> NavigationManager {
        switch route {
        case .navigation:
            return self
        case .sheet:
            return NavigationManager(isPresented: presentingSheet)
        case .fullScreenCover:
            return NavigationManager(isPresented: presentingFullScreen)
        case .modal:
            return NavigationManager(isPresented: presentingModal)
        case .modalCanFullScreen:
            return NavigationManager(isPresented: presentingModalCanFullScreen)
        }
    }
}
