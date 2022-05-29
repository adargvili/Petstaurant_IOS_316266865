//
//  PostListTableViewController.swift
//  Petstaurant_IOS_316266865
//
//  Created by Dror Bank on 29/05/2022.
//

import UIKit

class PostListTableViewController: UITableViewController {
    
    var row = 0
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.instance.postList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postCell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell
        postCell?.id = Model.instance.postList[indexPath.row].postDescription
        postCell?.postTitle = Model.instance.postList[indexPath.row].postTitle

        return postCell!
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        row = indexPath.row
        performSegue(withIdentifier: "openPostDetails", sender: self)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openPostDetails"{
            let detailViewController = segue.destination as? DetailViewController
            let postByRow = Model.instance.postList[row]
            detailViewController?.post = postByRow
        }
    }


}
