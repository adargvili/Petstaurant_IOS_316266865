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
        Model.instance.btnBorderColor(button: profileCameraImage){}
        Model.instance.btnBorderColor(button: profileGalleryImage){}
        Model.instance.btnBorderColor(button: continueBtn){}
        Model.instance.getCoreUser(uid:String(UserDefaults.standard.string(forKey: "uid")!)){
            user in
            let u = user
            if u.profileImageUrl != "" && u.profileImageUrl != nil {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let resultViewController = storyBoard.instantiateViewController(withIdentifier: "viewController") as! ViewController
                self.navigationController?.pushViewController(resultViewController, animated: true)
            }
        }
    }
    
    @IBAction func continueBtnTapped(_ sender: Any) {
        
        if let image = selectedImage{
            self.startLoading()
            Model.instance.uploadImage(name: String(UserDefaults.standard.string(forKey: "uid")!), image: image) { url in
                Model.instance.updateUserOnDB(uid: String(UserDefaults.standard.string(forKey: "uid")!),
                                              key: "profileImageUrl",
                                              value: url){
                    self.stopLoading()
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let resultViewController = storyBoard.instantiateViewController(withIdentifier: "viewController") as! ViewController
                    self.navigationController?.pushViewController(resultViewController, animated: true)
                    return
                }
            }
        }
        else{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let resultViewController = storyBoard.instantiateViewController(withIdentifier: "viewController") as! ViewController
            self.navigationController?.pushViewController(resultViewController, animated: true)
            return
        }
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
//        takePicture(source: .camera)
    }
    
    @IBAction func openProfileGallery(_ sender: Any) {
        takePicture(source: .photoLibrary)
    }
    
    
}
