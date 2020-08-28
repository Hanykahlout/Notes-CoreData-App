//
//  CategoriesViewController.swift
//  Notes
//
//  Created by Hany Kh on 18/08/2020.
//  Copyright © 2020 Hany Kh. All rights reserved.
//

import UIKit
import SCLAlertView
class CategoriesViewController: UIViewController {
    @IBOutlet weak var categoriesTableView: UITableView!
    var categoriesManager:CategoriesController!
    var userManager:UserManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        initalization()
        removeBackgroungNavBar()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        categoriesTableView.reloadData()
    }
    
    @IBAction func settingsAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "SettingsViewController") as! SettingsViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @IBAction func addCategriesAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "NewCategoryViewController") as! NewCategoryViewController
        
        vc.isSave = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func initalization() {
        categoriesManager = CategoriesController()
        userManager = UserManager()
        
        setDelegate()
    }
    
    
    func removeBackgroungNavBar(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
        
    }
    
}
extension CategoriesViewController : UITableViewDelegate , UITableViewDataSource{
    func setDelegate() {
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userManager.read().categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoriesCellTableViewCell", for: indexPath) as! categoriesCellTableViewCell
        let cate =  userManager.read().categories?.allObjects[indexPath.row] as! Categories
        cell.setCategory(category:cate)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "CategoriesNoteViewController") as! CategoriesNoteViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension CategoriesViewController : categoryCell{
    func delete(name: String) {
        
        let isDeleted = categoriesManager.delete(name: name)
        if isDeleted {
            categoriesTableView.deleteRows(at: <#T##[IndexPath]#>, with: <#T##UITableView.RowAnimation#>)
            SCLAlertView().showInfo("Succefull Deleted", subTitle: "The Category has been deleted")
        }else{
            SCLAlertView().showError("Error", subTitle: "The Category has not been deleted")
        }
    }
    
    func update(oldName: String,oldDescription:String) {
        let vc = storyboard?.instantiateViewController(identifier: "NewCategoryViewController") as! NewCategoryViewController
        vc.isSave = false
        vc.oldName = oldName
        vc.oldDescription = oldDescription
        present(vc, animated: true, completion: nil)
    }
    
    
}
