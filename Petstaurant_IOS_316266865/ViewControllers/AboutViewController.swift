//
//  AboutViewController.swift
//  Petstaurant_IOS_316266865
//
//  Created by Dror Bank on 29/05/2022.
//

import UIKit

class AboutViewController: UIViewController {


    @IBOutlet var aboutLabel: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        Model.instance.txtViewBorderColor(textView: aboutLabel){}
        aboutLabel.isEditable = false
        aboutLabel.text = "Hello Dear: " + String(UserDefaults.standard.string(forKey: "email")!) + " !\n\n\nWelcome to Petstaurant !\n\nIf You Like Pets, You'll Love Us!"
    }


}
