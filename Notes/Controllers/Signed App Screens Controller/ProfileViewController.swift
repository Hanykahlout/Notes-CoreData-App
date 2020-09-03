//
//  ProfileViewController.swift
//  Notes
//
//  Created by Hany Kh on 21/08/2020.
//  Copyright © 2020 Hany Kh. All rights reserved.
//

import UIKit
import SCLAlertView
class ProfileViewController: UIViewController {
    
    @IBOutlet weak var characterLabel: UILabelDesignable!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var categoriesNumber: UILabel!
    @IBOutlet weak var doneNotesNumber: UILabel!
    @IBOutlet weak var waitingNotesNumber: UILabel!
    
    @IBOutlet weak var firstNameTextField: BottomBorderTextField!
    
    @IBOutlet weak var lastNameTextField: BottomBorderTextField!
    
    
    @IBOutlet weak var phoneNumberTextField: BottomBorderTextField!
    
    @IBOutlet weak var emailTextField: BottomBorderTextField!
    var userManager:UserManager!
    var user:Users!
    var userController:UserController!
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    func initlization() {
        userManager = UserManager()
        user = userManager.read()
        userController = UserController()
        clearBackgroundNavBar()
        setUserInfo()
        
    }
    func setUserInfo() {
        fillUserInfo()
        let categories = user.categories?.allObjects as! [Categories]
        categoriesNumber.text = String(categories.count)
        setDoneAndWaitingNumber()
        fillTextFields()
    }
    func fillUserInfo() {
        nameLabel.text = user.firstName! + " " + user.lastName!
        emailLabel.text = user.email!
        characterLabel.text = String(user.firstName!.prefix(1))
    }
    func fillTextFields() {
        firstNameTextField.text = user.firstName!
        lastNameTextField.text = user.lastName!
        phoneNumberTextField.text = user.phoneNumber!
        emailTextField.text = user.email!
    }
    func setDoneAndWaitingNumber() {
        let categories = user.categories?.allObjects as! [Categories]
        var doneNotesNumber = 0
        var waitingNotesNumber = 0
        for everyCategory in categories{
            let notes = everyCategory.notes?.allObjects as! [Note]
            for everyNote in notes {
                if everyNote.stauts{
                    doneNotesNumber += 1
                }else{
                    waitingNotesNumber += 1
                }
            }
        }
        self.doneNotesNumber.text = String(doneNotesNumber)
        self.waitingNotesNumber.text = String(waitingNotesNumber)
    }
    @IBAction func saveAction(_ sender: Any) {
        performUpdate()
    }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    func clearBackgroundNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
        
    }
    
}
extension ProfileViewController {
    func performUpdate()  {
        if cheackData(){
            update()
            fillUserInfo()
        }else{
            SCLAlertView().showError("Error", subTitle: "You Should Fill All Text Fileds !! ☹️☹️☹️")
        }
    }
    func cheackData() -> Bool {
        if !firstNameTextField.text!.isEmpty &&
         !lastNameTextField.text!.isEmpty &&
         !phoneNumberTextField.text!.isEmpty &&
            !emailTextField.text!.isEmpty{
            return true
        }
        return false
    }
    
    func update() {
        let firstName =  firstNameTextField.text!
        let lastName = lastNameTextField.text!
        let email = emailTextField.text!
        let phoneNumber = phoneNumberTextField.text!
        let isUpdated = userController.update(userId: user.id!, firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber)
        if isUpdated{
            SCLAlertView().showInfo("Succefully Updated", subTitle: "The User Has Been Updated 😍😍😍")
            clear()
        }else{
            SCLAlertView().showError("Error", subTitle: "The User Has Not Been Updated ☹️☹️☹️")
        }
    }
    func clear() {
        firstNameTextField.text = ""
        lastNameTextField.text = ""
        phoneNumberTextField.text = ""
        emailTextField.text = ""
    }
}
