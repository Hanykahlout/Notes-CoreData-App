//
//  newNoteViewController.swift
//  Notes
//
//  Created by Hany Kh on 20/08/2020.
//  Copyright © 2020 Hany Kh. All rights reserved.
//

import UIKit

class newNoteViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: BottomBorderTextField!
    @IBOutlet weak var descriptionTextField: BottomBorderTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        initlaztion()
        // Do any additional setup after loading the view.
    }
    func initlaztion() {
        clearBackgroundNavBar()
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
    }
    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func clearBackgroundNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
    }
    
    
    
}
