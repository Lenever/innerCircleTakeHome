//
//  Coordinator.swift
//  innerCircleTakeHome
//
//  Created by Ikechukwu Onuorah on 16/12/2025.
//

import UIKit
import SwiftUI

class Coordinator {
    static let shared = Coordinator(startingRoute: .login)
    
    let navigationController: UINavigationController
    let startingRoute: InnerCircleRouter?
    
    private init(
        navigationController: UINavigationController = .init(),
        startingRoute: InnerCircleRouter? = nil
    ) {
        self.navigationController = navigationController
        self.startingRoute = startingRoute
    }
    
    func start() {
        guard let route = startingRoute else { return }
        show(route, setAsRootView: true)
    }
    
    func show(
        _ route: InnerCircleRouter,
        setAsRootView: Bool = false,
        animated: Bool = true
    ) {
        let view = route.view()
        let viewController = view
        
        if setAsRootView {
            self.setAsRootView(viewController)
        } else {
            switch route.transition {
            case .push:
                navigationController.pushViewController(viewController, animated: animated)
            case .presentModally:
                viewController.modalPresentationStyle = .formSheet
                navigationController.present(viewController, animated: animated)
            case .setAsRootView:
                self.setAsRootView(viewController)
            }
        }
    }
    
    func pop(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
    
    func popToRoot(animated: Bool = true) {
        navigationController.popToRootViewController(animated: animated)
    }
    
    open func setAsRootView(_ viewController: UIViewController, animated: Bool = false) {
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.setViewControllers([viewController], animated: animated)
    }
    
    open func dismiss(animated: Bool = false) {
        navigationController.dismiss(animated: animated)
    }

}
