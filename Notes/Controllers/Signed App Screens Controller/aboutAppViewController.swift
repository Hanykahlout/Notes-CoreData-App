//
//  aboutAppViewController.swift
//  Notes
//
//  Created by Hany Kh on 21/08/2020.
//  Copyright © 2020 Hany Kh. All rights reserved.
//

import UIKit

class aboutAppViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initlization()

    }
    func initlization() {
        clearBackgroundNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
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
