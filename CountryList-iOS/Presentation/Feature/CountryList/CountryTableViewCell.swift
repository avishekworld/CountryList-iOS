//
//  CountryTableViewCell.swift
//  CountryList-iOS
//
//  Created by Md Avishek Ahmed on 11/25/22.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var capitalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
