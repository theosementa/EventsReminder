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
    
    // sheet
    func presentCreateNewEvent(viewModel: Binding<CreateNewEventViewModel>, dismissAction: (() -> Void)? = nil) {
        presentSheet(.createNewEvent(viewModel: viewModel), dismissAction)
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
            case .home:
                HomeView(router: router(route: route))
            case .createNewEvent(let viewModel):
                CreateNewEventView(viewModel: viewModel)
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
