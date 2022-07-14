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
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "person.circle"),
            style:.done,
            target: self,
            action: #selector(logoutAction)
        )

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.black
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    @objc fileprivate func logoutAction(){
        Model.instance.logoutUser(){}
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpViewController
        self.navigationController?.setViewControllers([resultViewController], animated: true)
    }
    
}



extension UIViewController {
    func popupAlert(title: String?, message: String?, actionTitles:[String?], actions:[((UIAlertAction) -> Void)?]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: .default, handler: actions[index])
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    static let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

        func startLoading() {
            let activityIndicator = UIViewController.activityIndicator
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.style = .large
            activityIndicator.color = .black
            DispatchQueue.main.async {
                self.view.addSubview(activityIndicator)
            }
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
        }

        func stopLoading() {
            let activityIndicator = UIViewController.activityIndicator
            DispatchQueue.main.async {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
            UIApplication.shared.endIgnoringInteractionEvents()
          }
}

