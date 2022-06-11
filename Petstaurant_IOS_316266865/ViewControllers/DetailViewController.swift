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
    
    @IBOutlet weak var detailActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var navBtn: UINavigationItem!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var postDescriptionLabel: UITextView!
    @IBOutlet weak var postTitleLabel: UITextField!
    @IBOutlet weak var cancelDetailBtn: UIButton!
    @IBOutlet weak var SaveDetailBtn: UIButton!
    @IBOutlet weak var galleryDetailBtn: UIButton!
    @IBOutlet weak var cameraDetailBtn: UIButton!
    @IBOutlet weak var deleteDetailBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        avatar.layer.cornerRadius=40
        avatar.clipsToBounds=true
        Model.instance.btnBorderColor(button: galleryDetailBtn){}
        Model.instance.btnBorderColor(button: cameraDetailBtn){}
        Model.instance.btnBorderColor(button: SaveDetailBtn){}
        Model.instance.btnBorderColor(button: cancelDetailBtn){}
        Model.instance.btnBorderColor(button: deleteDetailBtn){}
        Model.instance.txtViewBorderColor(textView: postDescriptionLabel){}
        Model.instance.txtFieldBorderColor(textField: postTitleLabel){}
        
        postDescriptionLabel.text = post?.postDescription
        postTitleLabel.text = post?.postTitle
        if post?.postImage != "", let urlStr = post?.postImage {
            self.detailActivityIndicator.isHidden=false
            self.detailActivityIndicator.startAnimating()
            let url = URL(string: urlStr)
            avatar?.kf.setImage(with: url, options:[.forceRefresh]){ result in
                switch result {
                case .success(_):
                    self.detailActivityIndicator.isHidden=true
                case .failure(_):
                    self.popupAlert(title: "Edit Post Error",
                                    message: "Failed to upload post image",
                                    actionTitles: ["OK"], actions:[{action1 in},{action2 in}, nil]);return;
                }
            }
        }else{
            avatar.image = UIImage(named: "dish")
        }
        
        if post?.uid == String(UserDefaults.standard.string(forKey: "uid")!){
            postDescriptionLabel.isEditable = true
            postTitleLabel.isEnabled = true
            cancelDetailBtn.isHidden = false
            SaveDetailBtn.isHidden = false
            galleryDetailBtn.isHidden = false
            cameraDetailBtn.isHidden = false
            deleteDetailBtn.isHidden = false
            
        }
        else {
            postDescriptionLabel.isEditable = false
            postTitleLabel.isEnabled = false
            cancelDetailBtn.isHidden = true
            SaveDetailBtn.isHidden = true
            galleryDetailBtn.isHidden = true
            cameraDetailBtn.isHidden = true
            deleteDetailBtn.isHidden = true
        }
        
        
        
        
    }
    
    
    @IBAction func saveDetailTapped(_ sender: Any) {
        
        if(postTitleLabel.text! == "" || postDescriptionLabel.text! == "" ){
            self.popupAlert(title: "Edit Post Error",
                            message: "At least one of the fields is empty",
                            actionTitles: ["OK"], actions:[{action1 in},{action2 in}, nil]);return;}
        
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
//        takePicture(source: .camera)
    }
    
    @IBAction func deleteDetailBtnTapped(_ sender: Any) {
        Model.instance.deletePost(id: post?.id ?? ""){}
        let viewController = self.navigationController?.parent as! ViewController
        viewController.removeSubViews()
        viewController.performSegue(withIdentifier: "postListSegue", sender: self)
    }
    
}


