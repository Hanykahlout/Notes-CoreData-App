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
    
    
    //
    //    func isExist(firstName:String,lastName:String) -> (isExist:Bool,user:Users?) {
    //
    //        do{
    //            let fetchRe:NSFetchRequest = Users.fetchRequest()
    //            fetchRe.fetchLimit = 1
    //            fetchRe.predicate = NSPredicate(format: "firstName = %@", firstName)
    //            fetchRe.predicate = NSPredicate(format: "lastName = %@", lastName)
    //            let user = try context.fetch(fetchRe)
    //            if !user.isEmpty{
    //                if let _user = user.first{
    //                    return (true,_user)
    //                }
    //            }
    //        }catch let error as NSError{
    //            print(error)
    //        }
    //        SCLAlertView().showError("Error", subTitle: "Invaild User Name")
    //        return (false,nil)
    //    }
    
    
}
