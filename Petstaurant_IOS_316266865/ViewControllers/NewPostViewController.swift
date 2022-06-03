//
//  NewPostViewController.swift
//  Petstaurant_IOS_316266865
//
//  Created by Dror Bank on 29/05/2022.
//


import UIKit

class NewPostViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var galleryBtn: UIButton!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var postDescriptionInput: UITextField!
    @IBOutlet weak var postTitleInput: UITextField!
    @IBOutlet weak var avatarImgv: UIImageView!
    @IBAction func saveBtn(_ sender: UIButton) {
        if let image = selectedImage{
            let post = Post(uid: String(UserDefaults.standard.string(forKey: "uid")!) , postDescription: postDescriptionInput.text!, postTitle: postTitleInput.text!,postImage: "")
            Model.instance.uploadImage(name: post.id!, image: image) { url in
                post.postImage = url
                Model.instance.addPostToList(post: post){}
            }
        }else{
        }
        
        let viewController = self.navigationController?.parent as! ViewController
        viewController.removeSubViews()
        viewController.performSegue(withIdentifier: "postListSegue", sender: self)
    }
    @IBAction func xBtn(_ sender: UIButton) {
        postDescriptionInput.text = ""
        postTitleInput.text = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.postTitleInput.delegate=self
        self.postDescriptionInput.delegate=self
        
    }
    
    func textFieldShouldReturn(textField: UITextField)->Bool{
        textField.resignFirstResponder()
        return true
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
        self.avatarImgv.image = selectedImage
        self.dismiss(animated: true, completion: nil)

    }
    
    @IBAction func openCamera(_ sender: Any) {
        takePicture(source: .camera)
    }
    @IBAction func openGallery(_ sender: Any) {
        takePicture(source: .photoLibrary)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
