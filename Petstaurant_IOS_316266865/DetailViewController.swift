//
//  DetailViewController.swift
//  Petstaurant_IOS_316266865
//
//  Created by Dror Bank on 29/05/2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    var student:Post?{
        didSet{
            if postTitleLabel != nil{postTitleLabel.text = student?.postTitle}
            if idLabel != nil {idLabel.text = student?.postDescription}
        }
    }

    @IBOutlet weak var navBtn: UINavigationItem!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        avatar.layer.cornerRadius=40
        avatar.clipsToBounds=true
        idLabel.text = student?.postDescription
        postTitleLabel.text = student?.postTitle
        
    }
    

}

