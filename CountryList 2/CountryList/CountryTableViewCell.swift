//
//  CountryTableViewCell.swift
//  FoodTracker
//
//  Created by Eric on 4/15/19.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var citizenLabel: UILabel!
    @IBOutlet weak var datesLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
