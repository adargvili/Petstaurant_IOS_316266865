//
//  AboutViewController.swift
//  Petstaurant_IOS_316266865
//
//  Created by Dror Bank on 29/05/2022.
//

import UIKit
import AVFoundation

class AboutViewController: UIViewController {

    var videoPlayer:AVPlayer?
    var videoPlayerLayer:AVPlayerLayer?
    @IBOutlet var aboutLabel: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stopLoading()
        view.backgroundColor = .white
        Model.instance.txtViewBorderColor(textView: aboutLabel){}
        aboutLabel.isEditable = false
        aboutLabel.text = "Hello Dear: " + String(UserDefaults.standard.string(forKey: "email")!) + " !\n\n\nWelcome to Petstaurant !\n\nIf You Like Pets, You'll Love Us!"
    }


    override func viewWillAppear(_ animated: Bool) {
        setUpVideo()
    }
    
    
    func setUpVideo(){
        let bundlePath = Bundle.main.path(forResource: "DogReviews", ofType: "mp4")
        guard bundlePath != nil else{
            return
        }
        let url   = URL(fileURLWithPath: bundlePath!)
        let item = AVPlayerItem(url: url)
        videoPlayer = AVPlayer(playerItem: item)
        videoPlayerLayer = AVPlayerLayer(player:videoPlayer!)
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5,
                                         y:0,
                                         width: self.view.frame.size.width*4,
                                         height: self.view.frame.size.height)
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        videoPlayer?.isMuted = true
        videoPlayer?.playImmediately(atRate: 0.3)
    }
}
