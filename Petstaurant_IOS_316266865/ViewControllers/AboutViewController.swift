//
//  AboutViewController.swift
//  Petstaurant_IOS_316266865
//
//  Created by Dror Bank on 29/05/2022.
//

import UIKit

class AboutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        print(String(UserDefaults.standard.string(forKey: "uid")!))
        print(String(UserDefaults.standard.string(forKey: "email")!))

    }


}
