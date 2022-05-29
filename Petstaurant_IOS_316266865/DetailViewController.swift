//
//  DetailViewController.swift
//  Petstaurant_IOS_316266865
//
//  Created by Dror Bank on 29/05/2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    var post:Post?{
        didSet{
            if postTitleLabel != nil{postTitleLabel.text = post?.postTitle}
            if titleDescriptionLabel != nil {titleDescriptionLabel.text = post?.postDescription}
        }
    }

    @IBOutlet weak var navBtn: UINavigationItem!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var titleDescriptionLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        avatar.layer.cornerRadius=40
        avatar.clipsToBounds=true
        titleDescriptionLabel.text = post?.postDescription
        postTitleLabel.text = post?.postTitle
        
    }
    

}

