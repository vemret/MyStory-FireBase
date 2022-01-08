//
//  UserSingleton.swift
//  MyStory
//
//  Created by Vahit Emre TELLİER on 8.01.2022.
//

import Foundation

class UserSingleton {
    
    static let sharedUserInfo = UserSingleton()
    
    var email = ""
    var userName = ""
    
    private init() {
        
    }
    
}
