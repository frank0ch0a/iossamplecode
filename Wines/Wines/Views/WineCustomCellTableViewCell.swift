//
//  WineCustomCellTableViewCell.swift
//  Wines
//
//  Created by Lagash Systems on 09/03/2020.
//  Copyright © 2020 Lagash Systems. All rights reserved.
//

import UIKit

class WineCustomCellTableViewCell: UITableViewCell {

    @IBOutlet weak var wineImageView: UIImageView!
    @IBOutlet weak var wineNameLabel: UILabel!
    
    @IBOutlet weak var wineryNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        wineImageView.image = nil
    }
}
