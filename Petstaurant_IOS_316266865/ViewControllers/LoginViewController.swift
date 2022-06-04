//
//  LoginViewController.swift
//  Petstaurant_IOS_316266865
//
//  Created by Dror Bank on 29/05/2022.
//

import UIKit
import AVFoundation

class LoginViewController: UIViewController {
    
    
    var videoPlayer:AVPlayer?
    var videoPlayerLayer:AVPlayerLayer?
    @IBOutlet weak var emailLoginTextField: UITextField!
    @IBOutlet weak var passwordLoginTextField:UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var errorLoginBtn: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        Model.instance.tfBorderColor(textField: emailLoginTextField){}
        Model.instance.tfBorderColor(textField: passwordLoginTextField){}
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpVideo()
    }
    
    
    @IBAction func loginTapped(_ sender: Any) {
        
        var fields = [String]()
        fields.append(emailLoginTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines))
        fields.append(passwordLoginTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines))
        
        
        if !Model.instance.validateEmptyFields(fields: fields){errorLoginBtn.text = "At least one of the fields is empty";return;}
        
        if !Model.instance.validateEmail(email: emailLoginTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)){errorLoginBtn.text = "Email is not valid";return;}
        
        if !Model.instance.validatePassword(password: passwordLoginTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)){errorLoginBtn.text = "Minimum 8 and Maximum 10 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character";return;}
        
        
        Model.instance.loginUser(email: emailLoginTextField.text!, password: passwordLoginTextField.text!, onSuccess: {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "viewController") as! ViewController
            self.navigationController?.pushViewController(resultViewController, animated: true)
            return
        }) { (errorMsg) in
            self.errorLoginBtn.text = errorMsg
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
