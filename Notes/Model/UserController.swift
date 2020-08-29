//
//  UserManager.swift
//  Notes
//
//  Created by Hany Kh on 23/08/2020.
//  Copyright © 2020 Hany Kh. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import SCLAlertView

class UserController {
    
    var context:NSManagedObjectContext!
    
    init(){
        initilization()
    }
    func initilization(){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        context = appDelegate.persistentContainer.viewContext
    }
    
    func create(user:Users) -> Bool  {
        
        do{
            context.insert(user)
            try context.save()
            return true
        }catch let error as NSError{
            print(error)
        }
        
        return false
    }
    
    func read() -> [Users]? {
        do {
            let fetchR:NSFetchRequest = Users.fetchRequest()
            return try context.fetch(fetchR)
        }catch let error as NSError{
            print(error)
        }
        return nil
    }
    func update(userId:String,firstName:String,lastName:String,email:String,phoneNumber:String) -> Bool {
        do{
            let fetchR:NSFetchRequest = Users.fetchRequest()
            fetchR.fetchLimit = 1
            fetchR.predicate = NSPredicate(format: "id = %@", userId)
            let users = try context.fetch(fetchR)
            if !users.isEmpty{
                if let _user = users.first{
                    _user.setValue(firstName, forKey: "firstName")
                    _user.setValue(lastName, forKey: "lastName")
                    _user.setValue(phoneNumber, forKey: "phoneNumber")
                    _user.setValue(email, forKey: "email")
                    
                    try context.save()
                    
                    return true
                }
            }else{
                SCLAlertView().showError("Error", subTitle: "Category Not Found !!")
            }
        }catch let error as NSError{
            print(error)
        }
        return false
    }
    func getUserById(userId:String) -> Users? {
        do{
            let fetchRe:NSFetchRequest = Users.fetchRequest()
            fetchRe.fetchLimit = 1
            fetchRe.predicate = NSPredicate(format: "id = %@", userId)
            let users = try context.fetch(fetchRe)
            if !users.isEmpty{
                if let user = users.first{
                    return user
                }
            }
        }catch let error as NSError{
            print(error)
        }
        return nil
    }
    
    
    
    
}
