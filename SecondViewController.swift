//
//  SecondViewController.swift
//
//
//  Copyright © 2020 Muji. All rights reserved.
//

/**
 Purpose: View Controller for Title Screen
 */

import Foundation
import Alamofire
import SwiftyJSON
import CardParts
import RxSwift
import UIKit
import SwiftyGif
import SafariServices

class SecondViewController: UIViewController {
    
    
    @IBOutlet weak var logoView: UIView!
    let logoAnimationView = LogoAnimationView()
  
    @IBOutlet weak var mainText: UILabel!
    @IBOutlet weak var projectBtnOutlet: UIButton!
    
    /**
        Navigates to Repo in a Safari View
     */
    @IBAction func projectButton(_ sender: Any) {
        
        let projectURL = URL(string: "https://github.com/amujtaba00")
        let vc = SFSafariViewController(url
                                            : projectURL!)
        present(vc, animated: true, completion: nil)
    }
    @IBOutlet weak var buttonBackGround: UIImageView!
    
    //MARK:- VIEW DID LOAD
    /**
    Overide ViewDidLoad to do additional set up after super.viewDidLoad()
     */
    override func viewDidLoad() {
    super.viewDidLoad()
        
    // Hides Tab Bar + Add logoAnimationView
    self.tabBarController?.tabBar.isHidden = true
    self.buttonBackGround.layer.cornerRadius = 8
    logoView.addSubview(logoAnimationView)
    logoAnimationView.logoGifImageView.delegate = self
    
    
    
  }
    /**
     Override viewDidAppear to additional set up after super.viewDidAppear()
     */
    override func viewDidAppear(_ animated: Bool) {
        
        
            super.viewDidAppear(animated)
        // Start Animating the Gif
            logoAnimationView.logoGifImageView.startAnimatingGif()
        
        }
    
}

// Extension to conform to SwiftyGifDelegate Protocol
extension SecondViewController: SwiftyGifDelegate {
    
    // Runs after GIF animation is over
    func gifDidStop(sender: UIImageView) {
        // Hide & Remove GIF + Show Title, Project Button, TabBarController
        logoAnimationView.removeFromSuperview()
        projectBtnOutlet.isHidden = false
        buttonBackGround.isHidden = false
        mainText.textColor = UIColor.white
        mainText.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        
        
    }
}

