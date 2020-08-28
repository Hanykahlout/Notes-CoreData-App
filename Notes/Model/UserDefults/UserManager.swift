//
//  UserManager.swift
//  Notes
//
//  Created by Hany Kh on 23/08/2020.
//  Copyright © 2020 Hany Kh. All rights reserved.
//

import Foundation
class UserManager {
   
    func create(user:Users)  {
        UserDefaults.standard.set(user, forKey: "Users")
    }
    
    func read() -> Users {
        let user = UserDefaults.standard.object(forKey: "Users") as! Users
        return user
    }
    
}
