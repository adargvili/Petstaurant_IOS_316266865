//
//  SignUpViewController.swift
//  Petstaurant_IOS_316266865
//
//  Created by Dror Bank on 29/05/2022.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
   
    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBOutlet weak var errorLabel: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
