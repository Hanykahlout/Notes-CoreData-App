//
//  NewCategoryViewController.swift
//  Notes
//
//  Created by Hany Kh on 20/08/2020.
//  Copyright © 2020 Hany Kh. All rights reserved.
//

import UIKit
import SCLAlertView
class NewCategoryViewController: UIViewController {
    
    @IBOutlet weak var categoryNameTextField: BottomBorderTextField!
    @IBOutlet weak var descriptionTextField: BottomBorderTextField!
    @IBOutlet weak var screenTitleLabel: UILabel!
    var categoriesManager:CategoriesController!
    var isSave:Bool!
    var userManager:UserManager!
    var oldDescription:String?
    var oldName:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        // Do any additional setup after loading the view.
    }
    func initlization() {
        userManager = UserManager()
        categoriesManager = CategoriesController()
        setTitleLabel()
    }
   
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        performSave()
    }
    func setTitleLabel() {
        if isSave{
            screenTitleLabel.text = "New Category"
        }else{
            screenTitleLabel.text = "Update Category"
            categoryNameTextField.text = oldName
            descriptionTextField.text = oldDescription
        }
    }
    
}
extension NewCategoryViewController{
    func performSave() {
        if cheackData(){
            if !thereIsASameName(){
                
                isSave ? save() : update()
                
            }
        }
    }
    
    func cheackData() -> Bool {
        if !categoryNameTextField.text!.isEmpty &&
            !descriptionTextField.text!.isEmpty{
            return true
        }
        SCLAlertView().showError("Error", subTitle: "Fill All Field 😥 👎🏻")
        return false
    }
    
    
    func thereIsASameName() -> Bool{
        return categoriesManager.isExist(name: categoryNameTextField.text!)
    }
    func clear() {
        categoryNameTextField.text = ""
        descriptionTextField.text = ""
    }
    
    func save(){
        if !thereIsASameName(){
            
            
            let cate = Categories(context: categoriesManager.context)
            cate.name = categoryNameTextField.text!
            cate.descriptions = descriptionTextField.text!
            cate.user = userManager.read()
            let isCreated = categoriesManager.create(category: cate)
            if isCreated {
                clear()
                SCLAlertView().showInfo("Succefull Created", subTitle: "Category has been created 😀👍🏻")
            }else{
                SCLAlertView().showError("Error", subTitle: "Category has not been created 😥 👎🏻")
            }
        }
        
    }
    func update() {
        if !thereIsASameName(){
            let isUpdated = categoriesManager.update(oldName: oldName!, newName: categoryNameTextField.text!, newDescription: descriptionTextField.text!)
            if isUpdated{
                SCLAlertView().showInfo("Succefully Updated", subTitle: "Your Categry has been updated")
            }else{
                SCLAlertView().showError("Error", subTitle: "Your Category has not been updated")
            }
        }
    }
}
