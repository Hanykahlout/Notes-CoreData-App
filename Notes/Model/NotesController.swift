//
//  NotesController.swift
//  Notes
//
//  Created by Hany Kh on 29/08/2020.
//  Copyright © 2020 Hany Kh. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import SCLAlertView
class NoteController{
    
    var context:NSManagedObjectContext!
    
    init(){
        initilization()
    }
    func initilization(){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        context = appDelegate.persistentContainer.viewContext
    }
    
    func create(note:Note) -> Bool  {
        
        do{
            context.insert(note)
            try context.save()
            return true
        }catch let error as NSError{
            print(error)
        }
        
        return false
    }
    
    func read() -> [Note]? {
        do {
            let fetchR:NSFetchRequest = Note.fetchRequest()
            return try context.fetch(fetchR)
        }catch let error as NSError{
            print(error)
        }
        return nil
    }
    
    
    
    func update(noteId:String,newTitle:String,newDescription:String) -> Bool {
        do{
            let fetchR:NSFetchRequest = Note.fetchRequest()
            fetchR.fetchLimit = 1
            fetchR.predicate = NSPredicate(format: "id = %@", noteId)
            let note = try context.fetch(fetchR)
            if !note.isEmpty{
                if let _note = note.first{
                    _note.setValue(newTitle, forKey: "title")
                    _note.setValue(newDescription, forKey: "descriptions")
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
    func update(noteId:String,stauts:Bool) -> Bool {
        do{
            let fetchR:NSFetchRequest = Note.fetchRequest()
            fetchR.fetchLimit = 1
            fetchR.predicate = NSPredicate(format: "id = %@", noteId)
            let note = try context.fetch(fetchR)
            if !note.isEmpty{
                if let _note = note.first{
                    _note.setValue(stauts, forKey: "stauts")
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
    func delete(noteId:String) -> Bool {
        do{
            let fetchR:NSFetchRequest = Note.fetchRequest()
            fetchR.fetchLimit = 1
            fetchR.predicate = NSPredicate(format: "id = %@", noteId)
            let note = try context.fetch(fetchR)
            if !note.isEmpty{
                if let _note = note.first{
                    context.delete(_note)
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
