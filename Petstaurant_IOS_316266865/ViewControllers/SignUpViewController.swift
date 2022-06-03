//
//  SignUpViewController.swift
//  Petstaurant_IOS_316266865
//
//  Created by Dror Bank on 29/05/2022.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    @IBAction func SignUp(_ sender: Any) {
        var fields = [String]()
        fields.append(emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines))
        fields.append(nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines))
        fields.append(passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines))
        fields.append(confirmPasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines))
        
        
        if !Model.instance.validateEmptyFields(fields: fields){errorLabel.text = "At least one of the fields is empty";return;}
        
        if !Model.instance.validateEmail(email: emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)){errorLabel.text = "Email is not valid";return;}
        
        if !Model.instance.validatePassword(password: passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)){errorLabel.text = "Minimum 8 and Maximum 10 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character";return;}
        
        if !Model.instance.validatePasswordWithPasswordConfirm(password: passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines), passwordConfirm: confirmPasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)){errorLabel.text = "Password are not matched";return;}
        
        Model.instance.createUser(email: emailTextField.text!, password: passwordTextField.text!, userName: nameTextField.text!,profileImageUrl: "", onSuccess: {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "AboutVC") as! AboutViewController
            self.navigationController?.pushViewController(resultViewController, animated: true)
        }) { (errorMsg) in
            self.errorLabel.text = errorMsg
            return
        }
        
        
    }
}
