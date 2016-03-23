//
//  MonsterImg.swift
//  myTamagochi
//
//  Created by lucas fernández on 22/03/16.
//  Copyright © 2016 lucas fernández. All rights reserved.
//

import Foundation
import UIKit

class MonsterImg: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        playIdleAnimation()
    }
    
    func playIdleAnimation(){
        self.image = UIImage(named: "idle1.png")
        self.animationImages = nil //to clear the animationImages
        
        var imageArray = [UIImage]()
        for var x = 1 ; x <= 4 ; x += 1 {
            let img = UIImage(named: "idle\(x).png")
            imageArray.append(img!)
        }
        //self is called for the UIImage propierties
        //An array of images to stores the images and start animating
        self.animationImages = imageArray
        //Set de duration of the animation
        self.animationDuration = 0.8

        //With 0 is an infinite loop
        self.animationRepeatCount = 0
        self.startAnimating()
        
    }
    
    func playDeathAnimation() {
        self.image = UIImage(named: "dead5.png")
        self.animationImages = nil //to clear the animationImages
        
        var imageArray = [UIImage]()
        for var x = 1 ; x <= 5 ; x += 1 {
            let img = UIImage(named: "dead\(x).png")
            imageArray.append(img!)
        }
        //self is called for the UIImage propierties
        //An array of images to stores the images and start animating
        self.animationImages = imageArray
        //Set de duration of the animation
        self.animationDuration = 0.8
        //With 0 is an infinite loop
        self.animationRepeatCount = 1
        self.startAnimating()
    }
    
 
    
}