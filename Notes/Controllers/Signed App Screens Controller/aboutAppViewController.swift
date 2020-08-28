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
    @IBAction func backAction(_ sender: Any) {
    }
    func clearBackgroundNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
    }
    
}
