//
//  NewPostViewController.swift
//  Petstaurant_IOS_316266865
//
//  Created by Dror Bank on 29/05/2022.
//


import UIKit

class NewPostViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var idInput: UITextField!
    @IBOutlet weak var postTitleInput: UITextField!
    @IBAction func saveBtn(_ sender: UIButton) {
        let post = Post(postDescription: idInput.text!, postTitle: postTitleInput.text!)
        Model.instance.addPostToList(post: post)
        let viewController = self.navigationController?.parent as! ViewController
        viewController.removeSubViews()
        viewController.performSegue(withIdentifier: "studentListSegue", sender: self)
    }
    @IBAction func xBtn(_ sender: UIButton) {
        idInput.text = ""
        postTitleInput.text = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.postTitleInput.delegate=self
        self.idInput.delegate=self
        
    }
    
    func textFieldShouldReturn(textField: UITextField)->Bool{
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
