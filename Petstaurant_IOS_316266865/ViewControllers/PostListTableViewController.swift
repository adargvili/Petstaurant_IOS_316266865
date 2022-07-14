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
    var users = [User]()
    
    func reload(){
        Model.instance.getAllPosts(){
            posts in
            self.posts = posts
            self.tableView.reloadData()
        }
        
        Model.instance.getAllUsers(){
            users in
            self.users = users
            self.tableView.reloadData()
        }
        
    }
    
    var row = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stopLoading()
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Refresh My Feed")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
        Model.postDataNotification.observe {
            self.reload()
        }
        Model.userDataNotification.observe {
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

    @objc func refresh(_ sender: AnyObject) {
        self.reload()
        self.refreshControl!.endRefreshing()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postCell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell
        postCell?.postTitle = posts[indexPath.row].postTitle ?? ""
        Model.instance.getCoreUser(uid:posts[indexPath.row].uid!){
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
                        postCell?.cellActivityIndicator.isHidden=true
                    case .failure(_):
                        postCell?.cellActivityIndicator.isHidden=true
//                        self.popupAlert(title: "Post List Table Error",
//                                        message: "Failed to upload post image",
//                                        actionTitles: ["OK"], actions:[{action1 in},{action2 in}, nil]);return
                    }
                }
            }else{
                postCell?.avatarImage.image = UIImage(named: "dog")
            }
        }
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
