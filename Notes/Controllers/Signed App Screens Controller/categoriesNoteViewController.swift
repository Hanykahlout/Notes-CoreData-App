//
//  categoriesNoteViewController.swift
//  Notes
//
//  Created by Hany Kh on 20/08/2020.
//  Copyright © 2020 Hany Kh. All rights reserved.
//

import UIKit

class CategoriesNoteViewController: UIViewController {
    
    @IBOutlet weak var categoriesNoteTableView: UITableView!
    var notes:[Note] = [Note]()
    var category:Categories!
    var noteController:NoteController!
    override func viewDidLoad() {
        super.viewDidLoad()
        initalization() 
    }
    
    func initalization()  {
        noteController = NoteController()
        setDelegate()
        clearBackgroundNavBar()
    }
    @IBAction func backButoonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        setData()
    }
    @IBAction func addCategoriesNoteAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "NewNoteViewController") as! NewNoteViewController
        vc.category = self.category
        vc.isSave = true
        navigationController?.pushViewController(vc, animated: true)
    }
    func setData() {
        notes.removeAll()
        notes = category.notes?.allObjects as! [Note]
        categoriesNoteTableView.reloadData()
    }
    func clearBackgroundNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
    }
    
}
extension CategoriesNoteViewController : UITableViewDataSource , UITableViewDelegate{
    
    func setDelegate() {
        categoriesNoteTableView.delegate = self
        categoriesNoteTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoriesNameTableViewCell", for: indexPath) as! NoteTableViewCell
        cell.setNote(note: notes[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            let isDeleted = noteController.delete(noteId: notes[indexPath.row].id!)
            if isDeleted{
                notes.remove(at: indexPath.row)
                categoriesNoteTableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "NewNoteViewController") as! NewNoteViewController
        vc.isSave = false
        vc.note = notes[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
