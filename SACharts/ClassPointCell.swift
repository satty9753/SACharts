//
//  ClassPointCell.swift
//  CEOApp
//
//  Created by michelle on 2019/12/16.
//  Copyright © 2019 michelle. All rights reserved.
//

import UIKit

class ClassPointCell: UITableViewCell {
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .white
        numberLabel.textColor = .black
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
