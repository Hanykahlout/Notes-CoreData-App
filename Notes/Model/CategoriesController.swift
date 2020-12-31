//
//  CategoriesController.swift
//  Notes
//
//  Created by Hany Kh on 22/08/2020.
//  Copyright © 2020 Hany Kh. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import SCLAlertView
class CategoriesController {
    
    var context:NSManagedObjectContext!
    
    init(){
        setContext()
    }
    private func setContext() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return  }
        context = appDelegate.persistentContainer.viewContext
    }
    
    func create(category:Categories) -> Bool {
        do{
            context.insert(category)
            try context.save()
            return true
        }catch let error as NSError{
            print(error)
        }
        return false
    }
    func read() -> [Categories]? {
        do{
            let fetchR:NSFetchRequest = Categories.fetchRequest()
            return try context.fetch(fetchR)
        }catch let error as NSError{
            print(error)
        }
        return nil
    }
    func update(categoryId:String,newName:String,newDescription:String) -> Bool {
        do{
            let fetchR:NSFetchRequest = Categories.fetchRequest()
            fetchR.fetchLimit = 1
            fetchR.predicate = NSPredicate(format: "id = %@", categoryId)
            let category = try context.fetch(fetchR)
            if !category.isEmpty{
                if let _category = category.first{
                    _category.setValue(newName, forKey: "name")
                    _category.setValue(newDescription, forKey: "descriptions")
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
    
    func delete(categoryId:String) -> Bool {
        do{
            let fetchR:NSFetchRequest = Categories.fetchRequest()
            fetchR.fetchLimit = 1
            fetchR.predicate = NSPredicate(format: "id = %@", categoryId)
            let category = try context.fetch(fetchR)
            if !category.isEmpty{
                if let _category = category.first{
                    context.delete(_category)
                    try context.save()
                    return true
                }
            }
        }catch let error as NSError {
            print(error)
        }
        return false
    }
    
}
