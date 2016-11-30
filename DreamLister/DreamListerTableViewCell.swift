//
//  DreamListerTableViewCell.swift
//  DreamLister
//
//  Created by Rafael Nicoleti on 29/11/16.
//  Copyright © 2016 Rafael Nicoleti. All rights reserved.
//

import UIKit

class DreamListerTableViewCell: UITableViewCell {

    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var lblNameItem: UILabel!
    @IBOutlet weak var lblPriceItem: UILabel!
    @IBOutlet weak var lblDetailItem: UILabel!
    
    func configureCell(item: Item){
        lblNameItem.text = item.title
        lblPriceItem.text = "$\(item.price)"
        lblDetailItem.text = item.details
    }
}
