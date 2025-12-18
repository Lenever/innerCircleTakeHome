//
//  User.swift
//  innerCircleTakeHome
//
//  Created by Ikechukwu Onuorah on 16/12/2025.
//

import Foundation
import UIKit

class User {
    static var shared: User = User()
    
    @Published var name: String?
    @Published var email: String?
    @Published var social: String?
    @Published var job: String?
    @Published var birthday: Date = .now
    @Published var isLoggedIn: Bool = false
    @Published var photo: UIImage?
    @Published var lifestyle: [Lifestyle: Bool] = {
        var dict = [Lifestyle: Bool]()
        Lifestyle.allCases.forEach { dict[$0] = false }
        return dict
    }()
    
    var confirmationDetails:[(String, String)] {
        [(Constants.nameTitle, name ?? ""),
         (Constants.emailTitle, email ?? ""),
         (Constants.socialsTitle, social ?? ""),
         (Constants.jobTitle, job ?? ""),
         (Constants.lifestyleTitle, lifestyle.filter{$0.value == true}.map(\.key.rawValue).joined(separator: ", ")),
         (Constants.birthdayTitle, birthday.description)
        ]
    }
    
    private init() {
        
    }
}

enum Lifestyle: String, CaseIterable, Identifiable {
    
    var id: Self { self }
    
    case spiritual = "Spiritual"
    case practical = "Practical"
    case sporty = "Sporty"
    case creative = "Creative"
    case alternate = "Alternate"
    case avantGarde = "Avant Garde"
    
}
