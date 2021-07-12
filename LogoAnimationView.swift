//
//  LogoAnimationView.swift
//  BasketballBible
//
//  Created by Muji on 2020-11-18.
//  Copyright © 2020 Muji. All rights reserved.
//
/**
    Custom Class LogoAnimationView,
 
    - Creates a custom class named LogoAnimationView which inherits from UIView
    - Class is used to show a GIF as a Loading Screen
 
 */
import UIKit
import SwiftyGif

class LogoAnimationView: UIView {

    // Creates custom UIImageView which shows the GIF
    let logoGifImageView = try! UIImageView(gifImage: UIImage(gifName: "loadingScreenGif.gif"), loopCount: 1)

        override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
        }

    // Private method to set constraints + add custom UIImageView to LogoAnimationView
        private func commonInit() {
            
            addSubview(logoGifImageView)
            logoGifImageView.translatesAutoresizingMaskIntoConstraints = false
            logoGifImageView.widthAnchor.constraint(equalToConstant: 414).isActive = true
            logoGifImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        }
    }
