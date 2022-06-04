//
//  ProfileImageViewController.swift
//  Petstaurant_IOS_316266865
//
//  Created by Dror Bank on 04/06/2022.
//

import UIKit

class ProfileImageViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var profileImageAvatar: UIImageView!
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
    

    
    func takePicture(source: UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source;
        imagePicker.allowsEditing = true
        if (UIImagePickerController.isSourceTypeAvailable(source))
        {
            self.present(imagePicker, animated: true, completion: nil)
        }
    }

    var selectedImage: UIImage?

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        selectedImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as? UIImage
        self.profileImageAvatar.image = selectedImage
        self.dismiss(animated: true, completion: nil)

    }
    
    @IBAction func openProfileCamera(_ sender: Any) {
        takePicture(source: .camera)
    }
    
    @IBAction func openProfileGallery(_ sender: Any) {
        takePicture(source: .photoLibrary)
    }
    
    
}
