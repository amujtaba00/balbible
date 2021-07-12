//
//  accoladesCell.swift
//  BasketballBible
//
//  Created by Muji on 2020-09-20.
//  Copyright © 2020 Muji. All rights reserved.
//

import UIKit

/**
 Custom Class Inherits from UITableViewCell for Accolades Cells in PlayerInfoViewController
 */

class accoladesCell: UITableViewCell {

    
    @IBOutlet weak var accoladesContentView: UIView!
    
    @IBOutlet weak var insideView: UIView!
    @IBOutlet weak var accoladesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        insideView.layer.borderWidth = 2
        insideView.layer.borderColor = UIColor.black.cgColor
        insideView.layer.backgroundColor = UIColor.white.cgColor
        insideView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
