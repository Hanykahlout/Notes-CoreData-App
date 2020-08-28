//
//  ProfileViewController.swift
//  Notes
//
//  Created by Hany Kh on 21/08/2020.
//  Copyright © 2020 Hany Kh. All rights reserved.
//

import UIKit

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()
        // Do any additional setup after loading the view.
    }
    func initlization() {
        clearBackgroundNavBar()
    }
    
    @IBAction func saveAction(_ sender: Any) {
    }
    
    func clearBackgroundNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
    }
    
}
