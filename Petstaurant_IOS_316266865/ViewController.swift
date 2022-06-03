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
            action: #selector(logoutAction)
        )
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gear"),
            style:.done,
            target: self,
            action: #selector(settings)
        )
        
    }
    
    @objc fileprivate func logoutAction(){
        Model.instance.logoutUser(){}
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpViewController
        self.navigationController?.setViewControllers([resultViewController], animated: true)
    }
    
    @objc fileprivate func settings(){
    }

}

