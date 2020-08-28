//
//  categoriesNoteViewController.swift
//  Notes
//
//  Created by Hany Kh on 20/08/2020.
//  Copyright © 2020 Hany Kh. All rights reserved.
//

import UIKit

class CategoriesNoteViewController: UIViewController {
    
    @IBOutlet weak var categoriesNameTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initalization() 
    }
    
    func initalization()  {
       setDelegate()
        clearBackgroundNavBar()
    }
    @IBAction func backButoonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addCategoriesNoteAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "newNoteViewController") as! newNoteViewController
        navigationController?.pushViewController(vc, animated: true)
    
    }
    func clearBackgroundNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
    }
    
}
extension CategoriesNoteViewController : UITableViewDataSource , UITableViewDelegate{
    
    func setDelegate() {
        categoriesNameTableView.delegate = self
        categoriesNameTableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoriesNameTableViewCell", for: indexPath) as! categoriesNameTableViewCell
        return cell
    }
    
    
    
}
