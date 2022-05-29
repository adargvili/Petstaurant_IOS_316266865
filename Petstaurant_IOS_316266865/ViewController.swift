//
//  ViewController.swift
//  Petstaurant_IOS_316266865
//
//  Created by Dror Bank on 29/05/2022.
//

import UIKit

class ViewController: UIViewController , MySegueProtocol {
    
    @IBAction func aboutBtn(_ sender: UIButton) {
        removeSubViews()
        performSegue(withIdentifier: "aboutSegue", sender: self)
    }
    @IBAction func addBtn(_ sender: UIButton) {
        removeSubViews()
        performSegue(withIdentifier: "addPostSegue", sender: self)
    }
    @IBAction func listBtn(_ sender: UIButton) {
        removeSubViews()
        performSegue(withIdentifier: "postListSegue", sender: self)
    }
    func getViewContainer(identifier: String) -> UIView {
        return containerView
    }
    
    @IBOutlet weak var containerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        performSegue(withIdentifier: "postListSegue", sender: self)
    }
    
    func removeSubViews(){
        for v in containerView.subviews{
            v.removeFromSuperview()
        }
    }

}

