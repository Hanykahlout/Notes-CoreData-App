//
//  SettingsViewController.swift
//  Notes
//
//  Created by Hany Kh on 20/08/2020.
//  Copyright © 2020 Hany Kh. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var settingsTabelView: UITableView!
    
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
        setDelegate()
        setData()
    }
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    func setData() {
        let user = userManager.read()
        nameLabel.text = user.firstName! + " \(user.lastName!)"
        emaiLabel.text = user.email!
    }
    
    func clearBackgroundNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
    }
    
}

extension SettingsViewController : UITableViewDelegate , UITableViewDataSource{
    
    func setDelegate(){
        settingsTabelView.delegate = self
        settingsTabelView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let languageCell = tableView.dequeueReusableCell(withIdentifier: "languageTableViewCell", for: indexPath) as! languageTableViewCell
        
        let profileCell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
        
        
        let aboutAppCell = tableView.dequeueReusableCell(withIdentifier: "AboutAppTableViewCell", for: indexPath) as! AboutAppTableViewCell
        
        
        let aboutCourseCell = tableView.dequeueReusableCell(withIdentifier: "AboutCourseTableViewCell", for: indexPath) as! AboutCourseTableViewCell
        
        
        let logoutCell = tableView.dequeueReusableCell(withIdentifier: "LogoutTableViewCell", for: indexPath) as! LogoutTableViewCell
        
        switch indexPath.row {
        case 0:
            return languageCell
        case 1:
            return profileCell
        case 2:
            return aboutAppCell
        case 3:
            return aboutCourseCell
        case 4:
            return logoutCell
        default:
            return languageCell
        }
        
        
    }
    
}
