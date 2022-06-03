//
//  LoginViewController.swift
//  Petstaurant_IOS_316266865
//
//  Created by Dror Bank on 29/05/2022.
//

import UIKit

class LoginViewController: UIViewController {
    


    @IBOutlet weak var emailLoginTextField: UITextField!
    @IBOutlet weak var passwordLoginTextField:UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var errorLoginBtn: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
    @IBAction func loginTapped(_ sender: Any) {
        Model.instance.loginUser(email: emailLoginTextField.text!, password: passwordLoginTextField.text!){}
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "AboutVC") as! AboutViewController
        self.navigationController?.pushViewController(resultViewController, animated: true)
        
    }
    
    
    
    
}
