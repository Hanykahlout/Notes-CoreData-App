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
    var user:Users!
    var category:Categories!
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        // Do any additional setup after loading the view.
    }
    func initlization() {
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
            categoryNameTextField.text = category.name!
            descriptionTextField.text = category.descriptions!
        }
    }
    
}
extension NewCategoryViewController{
    func performSave() {
        if cheackData(){
            isSave ? save() : update()
             
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
    
    func clear() {
        categoryNameTextField.text = ""
        descriptionTextField.text = ""
    }
    
    func save(){
        
        let cate = Categories(context: categoriesManager.context)
        cate.id = UUID().uuidString 
        cate.name = categoryNameTextField.text!
        cate.descriptions = descriptionTextField.text!
        cate.user = user
        let isCreated = categoriesManager.create(category: cate)
        if isCreated {
            clear()
            SCLAlertView().showInfo("Succefull Created", subTitle: "Category has been created 😀👍🏻")
            clear()
        }else{
            SCLAlertView().showError("Error", subTitle: "Category has not been created 😥 👎🏻")
        }
        
    }
    
    func update() {
        let isUpdated = categoriesManager.update(categoryId: category.id!, newName: categoryNameTextField.text!, newDescription: descriptionTextField.text!)
        if isUpdated{
            SCLAlertView().showInfo("Succefully Updated", subTitle: "Your Categry has been updated")
            clear()
        }else{
            SCLAlertView().showError("Error", subTitle: "Your Category has not been updated")
        }
    }
}
