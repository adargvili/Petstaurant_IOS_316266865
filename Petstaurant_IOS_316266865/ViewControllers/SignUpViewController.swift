//
//  SignUpViewController.swift
//  Petstaurant_IOS_316266865
//
//  Created by Dror Bank on 29/05/2022.
//

import UIKit
import AVFoundation

class SignUpViewController: UIViewController {
    var videoPlayer:AVPlayer?
    var videoPlayerLayer:AVPlayerLayer?
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userLoginStatus = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        if(userLoginStatus)
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "viewController") as! ViewController
            self.navigationController?.pushViewController(resultViewController, animated: true)
        }
        Model.instance.tfBorderColor(textField: emailTextField){}
        Model.instance.tfBorderColor(textField: nameTextField){}
        Model.instance.tfBorderColor(textField: passwordTextField){}
        Model.instance.tfBorderColor(textField: confirmPasswordTextField){}
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let userLoginStatus = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        if(userLoginStatus)
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "viewController") as! ViewController
            self.navigationController?.pushViewController(resultViewController, animated: true)
            
        }
        
        setUpVideo()
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
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "ProfileImageVC") as! ProfileImageViewController
            self.navigationController?.pushViewController(resultViewController, animated: true)
            return
        }) { (errorMsg) in
            self.errorLabel.text = errorMsg
            return
        }
        
        
    }
    
    
    
    func setUpVideo(){
        let bundlePath = Bundle.main.path(forResource: "DogReviews", ofType: "mp4")
        guard bundlePath != nil else{
            return
        }
        let url   = URL(fileURLWithPath: bundlePath!)
        let item = AVPlayerItem(url: url)
        videoPlayer = AVPlayer(playerItem: item)
        videoPlayerLayer = AVPlayerLayer(player:videoPlayer!)
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5,
                                         y:0,
                                         width: self.view.frame.size.width*4,
                                         height: self.view.frame.size.height)
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        videoPlayer?.isMuted = true
        videoPlayer?.playImmediately(atRate: 0.3)
    }
    
    
}
