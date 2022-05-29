//
//  PostTableViewCell.swift
//  Petstaurant_IOS_316266865
//
//  Created by Dror Bank on 29/05/2022.
//
import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postDescriptionLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    
    var postDescription = ""{
        didSet{
            if postDescriptionLabel != nil{postDescriptionLabel.text = postDescription}
        }
    }
    
    var postTitle = ""{
        didSet{
            if postTitleLabel != nil{postTitleLabel.text = postTitle}
        }
    }
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        postTitleLabel.text = postTitle
        postDescriptionLabel.text = postDescription
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        avatarImage.layer.masksToBounds=true
        avatarImage.layer.cornerRadius=avatarImage.bounds.width/2
    }

}

