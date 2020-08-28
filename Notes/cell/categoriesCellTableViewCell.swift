//
//  categoriesCellTableViewCell.swift
//  Notes
//
//  Created by Hany Kh on 19/08/2020.
//  Copyright © 2020 Hany Kh. All rights reserved.
//

import UIKit
protocol categoryCell {
    func delete(name:String)
    func update(oldName:String,oldDescription:String)
}
class categoriesCellTableViewCell: UITableViewCell {

    @IBOutlet weak var workLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabelDesignable!
    var delegate:categoryCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCategory(category:Categories) {
        workLabel.text = category.name
        noteLabel.text = category.descriptions
//        characterLabel.text = category.name!.first!
    }
    
    @IBAction func editAction(_ sender: Any) {
        if let _delegate = delegate{
            _delegate.update(oldName: workLabel.text!,oldDescription: noteLabel.text!)
        }
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        if let _delegate = delegate{
           _delegate.delete(name: workLabel.text!)
       }
    }
    
}
