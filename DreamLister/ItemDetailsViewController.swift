//
//  ItemDetailsViewController.swift
//  DreamLister
//
//  Created by Rafael Nicoleti on 30/11/16.
//  Copyright © 2016 Rafael Nicoleti. All rights reserved.
//

import UIKit

class ItemDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let itemTop = self.navigationController?.navigationBar.topItem {
            itemTop.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    }

}
