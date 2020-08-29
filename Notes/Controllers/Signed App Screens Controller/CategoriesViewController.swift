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
    var user:Users!
    var categoriesController:CategoriesController!
    var userManager:UserManager!
    var categories:[Categories] = [Categories]()
    override func viewDidLoad() {
        super.viewDidLoad()
        initalization()
        removeBackgroungNavBar()
    }
    
    func removeBackgroungNavBar(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
    }
    override func viewWillAppear(_ animated: Bool) {
        setCategories()
    }
    func initalization() {
        categoriesController = CategoriesController()
        userManager = UserManager()
        user = userManager.read()
        setDelegate()
        
    }
    func setCategories() {
        categories.removeAll()
        let allCategories = user.categories!.allObjects
        categories = allCategories as! [Categories]
        categoriesTableView.reloadData()
    }
    
    
    @IBAction func settingsAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "SettingsViewController") as! SettingsViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @IBAction func addCategriesAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "NewCategoryViewController") as! NewCategoryViewController
        vc.isSave = true
        vc.user = user
        navigationController?.pushViewController(vc, animated: true)
    }
}



extension CategoriesViewController : UITableViewDelegate , UITableViewDataSource{
    func setDelegate() {
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoriesCellTableViewCell", for: indexPath) as! categoriesCellTableViewCell
        cell.index = indexPath
        cell.setCategory(category:categories[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "CategoriesNoteViewController") as! CategoriesNoteViewController
        vc.category = categories[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension CategoriesViewController : categoryCell{
    func delete(index:IndexPath) {
        let isDeleted = categoriesController.delete(categoryId: categories[index.row].id!)
        if isDeleted {
            categories.remove(at: index.row)
            categoriesTableView.deleteRows(at: [index], with: .automatic)
            SCLAlertView().showInfo("Succefull Deleted", subTitle: "The Category has been deleted")
        }else{
            SCLAlertView().showError("Error", subTitle: "The Category has not been deleted")
        }
    }
    
    func update(index:IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "NewCategoryViewController") as! NewCategoryViewController
        let myCategory = categories[index.row]
        vc.isSave = false
        vc.category = myCategory
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
