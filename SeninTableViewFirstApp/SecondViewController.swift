//
//  SecondViewController.swift
//  SeninTableViewFirstApp
//
//  Created by Yegor Kozlovskiy on 20.03.2020.
//  Copyright © 2020 Yegor Kozlovskiy. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var strData : String?
    
    @IBOutlet weak var labelName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        labelName.text = strData
    }
}
