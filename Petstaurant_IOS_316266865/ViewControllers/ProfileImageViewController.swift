//
//  ProfileImageViewController.swift
//  Petstaurant_IOS_316266865
//
//  Created by Dror Bank on 04/06/2022.
//

import UIKit

class ProfileImageViewController: UIViewController {

    @IBOutlet weak var porfieImageAvatar: UIImageView!
    @IBOutlet weak var profileGalleryImage: UIButton!
    @IBOutlet weak var profileCameraImage: UIButton!
    @IBOutlet weak var continueBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func continueBtnTapped(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "viewController") as! ViewController
        self.navigationController?.pushViewController(resultViewController, animated: true)
        return
    }
    
}
