//
//  PostListTableViewController.swift
//  Petstaurant_IOS_316266865
//
//  Created by Dror Bank on 29/05/2022.
//

import UIKit
import Kingfisher

class PostListTableViewController: UITableViewController {
    
    var posts = [Post]()
    
    func reload(){
        Model.instance.getAllPosts(){
            posts in
            self.posts = posts
            self.tableView.reloadData()
        }
    }
    
    var row = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        Model.postDataNotification.observe {
            self.reload()
        }
        reload()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postCell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell
        postCell?.postTitle = posts[indexPath.row].postTitle ?? ""
        Model.instance.getUser(uid:posts[indexPath.row].uid!){
            user in
            let u = user
            postCell?.postUserName = u.userName ?? ""
            if u.profileImageUrl != "", let urlStr = u.profileImageUrl {
                postCell?.cellActivityIndicator.isHidden=false
                postCell?.cellActivityIndicator.startAnimating()
                let url = URL(string: urlStr)
                postCell?.avatarImage?.kf.setImage(with: url, options:[.forceRefresh]){ result in
                    switch result {
                    case .success(_):
                        print()
                        postCell?.cellActivityIndicator.isHidden=true
                    case .failure(_):
                        print()
                        postCell?.cellActivityIndicator.isHidden=true
                    }
                }
            }else{
                postCell?.avatarImage.image = UIImage(named: "dog")
            }
        }
//        postCell?.layer.borderWidth = 1
//        postCell?.layer.borderColor = UIColor.systemYellow.cgColor
//        if posts[indexPath.row].uid == String(UserDefaults.standard.string(forKey: "uid")!){
//            postCell?.backgroundColor = ç
//        }
//        else {
//            postCell?.backgroundColor = UIColor.black
//        }
        return postCell!
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        row = indexPath.row
        performSegue(withIdentifier: "openPostDetails", sender: self)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openPostDetails"{
            let detailViewController = segue.destination as? DetailViewController
            let postByRow = posts[row]
            detailViewController?.post = postByRow
        }
    }


}
