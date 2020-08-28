//
//  SignInViewController.swift
//  Notes
//
//  Created by Hany Kh on 18/08/2020.
//  Copyright © 2020 Hany Kh. All rights reserved.
//

import UIKit
import SCLAlertView

class SignInViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var userController:UserController!
    var userManager:UserManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        initalization()
    }
    
    func initalization(){
        setManager()
    }
    
    func setManager()  {
        userController = UserController()
        userManager = UserManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func LoginAction(_ sender: Any) {
        
        performSignin()
        
    }
    
    @IBAction func SignupAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension SignInViewController {
    
    func performSignin() {
        if cheackData(){
            if isExist(){
                if matchPassword(){
                    clear()
                    goToCategoriesScreen()
                }
            }
        }
    }
    
    func cheackData() -> Bool {
        if !userNameTextField.text!.isEmpty && !passwordTextField.text!.isEmpty{
            return true
        }
        SCLAlertView().showError("Error", subTitle: "Fill all the fields, There is empty fields")
        return false
    }
    
    func isExist() -> Bool {
        let userNameArray = userNameTextField.text!.split(separator: " ")
        if userNameArray.count == 2{
            
            if let firstName = userNameArray.first , let lastName = userNameArray.last{
                
                let allUser = userController.read()
                if let _allUser = allUser{
                    var isExist:Bool = false
                    for x in _allUser{
                        if x.firstName == String(firstName) && x.lastName == String(lastName){
                            isExist = true
                            userManager.create(user: x)
                            return true
                        }
                    }
                    if !isExist {
                        SCLAlertView().showError("Error", subTitle: "Invaild User Name")
                    }
                }
                
            }
        }else{
            SCLAlertView().showWarning("Error", subTitle: "You should enter first name and last name")
        }
        
        return false
        
    }
    
    
    func matchPassword() -> Bool {
        let user = userManager.read()
            if user.password == passwordTextField.text!{
                return true
            }
        
        SCLAlertView().showWarning("Error", subTitle: "Invaild Password")
        return false
    }
    func goToCategoriesScreen()  {
        let vc = storyboard?.instantiateViewController(identifier: "SecondNC") as! UINavigationController
        present(vc, animated: true)
    }
    func clear(){
        userNameTextField.text = ""
        passwordTextField.text = ""
    }
    
}
