//
//  AboutViewController.swift
//  Petstaurant_IOS_316266865
//
//  Created by Dror Bank on 29/05/2022.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet var aboutLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        aboutLabel.text = "Hello Dear: " + String(UserDefaults.standard.string(forKey: "email")!) + " !"
    }


}
