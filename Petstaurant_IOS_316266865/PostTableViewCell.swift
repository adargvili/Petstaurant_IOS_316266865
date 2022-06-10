//
//  PostTableViewCell.swift
//  Petstaurant_IOS_316266865
//
//  Created by Dror Bank on 29/05/2022.
//
import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postUserNameLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var cellActivityIndicator: UIActivityIndicatorView!
    
    var postTitle = ""{
        didSet{
            if postTitleLabel != nil{postTitleLabel.text = postTitle}
        }
    }
    
    var postUserName = ""{
        didSet{
            if postUserNameLabel != nil{postUserNameLabel.text = postUserName}
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        postUserNameLabel.text = postUserName
        postTitleLabel.text = postTitle
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        avatarImage.layer.masksToBounds=true
        avatarImage.layer.cornerRadius=avatarImage.bounds.width/2
    }

}

