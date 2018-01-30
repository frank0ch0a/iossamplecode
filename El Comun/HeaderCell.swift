//
//  HeaderCell.swift
//  El Comun
//
//  Created by Francisco Ochoa on 12/05/17.
//  Copyright © 2017 fochoa. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell {
    

    @IBOutlet weak var headerLabel: UILabel!
    
    var name = "" {
        didSet {
            headerLabel.text = name
            
        }
    }

}
