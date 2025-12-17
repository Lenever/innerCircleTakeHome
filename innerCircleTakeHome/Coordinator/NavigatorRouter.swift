//
//  NavigatorRouter.swift
//  innerCircleTakeHome
//
//  Created by Ikechukwu Onuorah on 16/12/2025.
//

import SwiftUI

enum NavigationTranisitionStyle {
    case push
    case presentModally
    case setAsRootView
}

protocol NavigationRouter {
    associatedtype V: UIViewController
    
    var transition: NavigationTranisitionStyle { get }
    
    func view() -> V
}

enum InnerCircleRouter: NavigationRouter, Equatable {
    
    static func == (lhs: InnerCircleRouter, rhs: InnerCircleRouter) -> Bool {
        lhs.value == rhs.value
    }
    
    var value: String? {
        return String(describing: self)
    }
    
    case onboarding
    case login
    case home
    
    var transition: NavigationTranisitionStyle {
        switch self {
        case .home:
            return .setAsRootView
        default:
            return .push
        }
    }
    
    func view() -> UIViewController {
        return switch self {
        case .onboarding:
            UIHostingController(rootView: OnboardingView())
        case .login:
            LoginViewController()
        case .home:
            HomeViewController()
        }
    }
    
}
