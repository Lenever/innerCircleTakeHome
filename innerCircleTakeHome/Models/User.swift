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
    var confirmationDetails:[(String, String)] {
        [(Constants.nameTitle, name ?? ""),
         (Constants.emailTitle, email ?? ""),
         (Constants.socialsTitle, social ?? ""),
         (Constants.jobTitle, job ?? ""),
         (Constants.birthdayTitle, birthday.description)
        ]
    }
    
    private init() {
        
    }
}
