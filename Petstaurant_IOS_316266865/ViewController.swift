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
        configureItems()
    }
    
    func removeSubViews(){
        for v in containerView.subviews{
            v.removeFromSuperview()
        }
    }
    
    private func configureItems(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "person.circle"),
            style:.done,
            target: self,
            action: nil
        )
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gear"),
            style:.done,
            target: self,
            action: nil
        )
        
    }

}

