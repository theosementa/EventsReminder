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
    
    // sheet
//    func presentCreateNewEntry(dismissAction: (() -> Void)? = nil) {
//        presentSheet(.createNewEntry, dismissAction)
//    }
    

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
