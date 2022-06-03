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
        
        var fields = [String]()
        fields.append(emailLoginTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines))
        fields.append(passwordLoginTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines))
        
        
        if !Model.instance.validateEmptyFields(fields: fields){errorLoginBtn.text = "At least one of the fields is empty";return;}
        
        if !Model.instance.validateEmail(email: emailLoginTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)){errorLoginBtn.text = "Email is not valid";return;}
        
        if !Model.instance.validatePassword(password: passwordLoginTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)){errorLoginBtn.text = "Minimum 8 and Maximum 10 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character";return;}
        
        
        Model.instance.loginUser(email: emailLoginTextField.text!, password: passwordLoginTextField.text!){}
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "AboutVC") as! AboutViewController
        self.navigationController?.pushViewController(resultViewController, animated: true)
        
    }
    
    
    
    
}
