//
//  SettingsViewController.swift
//  Notes
//
//  Created by Hany Kh on 20/08/2020.
//  Copyright © 2020 Hany Kh. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emaiLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabelDesignable!
    
    var userManager:UserManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initalization()
        
    }
    func initalization() {
        userManager = UserManager()
        clearBackgroundNavBar()
        setData()
    }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func setData() {
        let user = userManager.read()
        nameLabel.text = user.firstName! + " \(user.lastName!)"
        emaiLabel.text = user.email!
        characterLabel.text = String(user.firstName!.prefix(1))
    }
    
    func clearBackgroundNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
    }
    
}
