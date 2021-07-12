//
//  prototypeCell.swift
//  BasketballBible
//
//  Created by Muji on 2020-09-17.
//  Copyright © 2020 Muji. All rights reserved.
//

import UIKit

/**
 Custom Class that inherits from UITableViewCell for Player Cells in SecondViewController
 */

class prototypeCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var imageLabel: UILabel!
    @IBOutlet weak var measurementsLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var yearsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        cardView.layer.cornerRadius = 5
        cardView.layer.borderColor = UIColor.darkGray.cgColor
        cardView.layer.borderWidth = 2
        cardView.layer.shadowColor = UIColor.lightGray.cgColor
        cardView.layer.shadowOpacity = 0.5
        
        
        
        //cardView.layer.backgroundColor = UIColor.lightGray.cgColor
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
