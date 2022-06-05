//
//  DetailViewController.swift
//  Petstaurant_IOS_316266865
//
//  Created by Dror Bank on 29/05/2022.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var post:Post?{
        didSet{
            if postTitleLabel != nil{postTitleLabel.text = post?.postTitle}
            if postDescriptionLabel != nil {postDescriptionLabel.text = post?.postDescription}
        }
    }
    
    @IBOutlet weak var navBtn: UINavigationItem!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var postDescriptionLabel: UITextField!
    @IBOutlet weak var postTitleLabel: UITextField!
    @IBOutlet weak var cancelDetailBtn: UIButton!
    @IBOutlet weak var SaveDetailBtn: UIButton!
    @IBOutlet weak var galleryDetailBtn: UIButton!
    @IBOutlet weak var cameraDetailBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatar.layer.cornerRadius=40
        avatar.clipsToBounds=true
        postDescriptionLabel.text = post?.postDescription
        postTitleLabel.text = post?.postTitle
        if let urlStr = post?.postImage {
            let url = URL(string: urlStr)
            avatar?.kf.setImage(with: url)
        }else{
            avatar.image = UIImage(named: "userAvatar")
        }
        
        if post?.uid == String(UserDefaults.standard.string(forKey: "uid")!){
            postDescriptionLabel.isEnabled = true
            postTitleLabel.isEnabled = true
            cancelDetailBtn.isHidden = false
            SaveDetailBtn.isHidden = false
            galleryDetailBtn.isHidden = false
            cameraDetailBtn.isHidden = false
            
        }
        else {
            postDescriptionLabel.isEnabled = false
            postTitleLabel.isEnabled = false
            cancelDetailBtn.isHidden = true
            SaveDetailBtn.isHidden = true
            galleryDetailBtn.isHidden = true
            cameraDetailBtn.isHidden = true
        }
        
        
        
        
    }
    
    
    @IBAction func saveDetailTapped(_ sender: Any) {
        
        Model.instance.updatePostOnDB(id: post?.id ?? "",
                                      key: "postDescription",
                                      value: postDescriptionLabel.text!){}
        
        Model.instance.updatePostOnDB(id: post?.id ?? "",
                                      key: "postTitle",
                                      value: postTitleLabel.text!){}
        
        if let image = selectedImage{
            Model.instance.uploadImage(name: post?.id ?? "", image: image) { url in
                Model.instance.updatePostOnDB(id: (self.post?.id)!, key: "postImage", value: url){}
            }
        }
        let viewController = self.navigationController?.parent as! ViewController
        viewController.removeSubViews()
        viewController.performSegue(withIdentifier: "postListSegue", sender: self)
        
    }
    
    @IBAction func cancelDetailTapped(_ sender: Any) {
        
        let viewController = self.navigationController?.parent as! ViewController
        viewController.removeSubViews()
        viewController.performSegue(withIdentifier: "postListSegue", sender: self)
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
        self.avatar.image = selectedImage
        self.dismiss(animated: true, completion: nil)

    }
    
    
    @IBAction func galleryDetailBtnTapped(_ sender: Any) {
        takePicture(source: .photoLibrary)
    }
    
    
    
    @IBAction func cameraDetailBtnTapped(_ sender: Any) {
        takePicture(source: .camera)
    }
    
}

