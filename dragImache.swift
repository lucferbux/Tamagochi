//
//  dragImache.swift
//  myTamagochi
//
//  Created by lucas fernández on 21/03/16.
//  Copyright © 2016 lucas fernández. All rights reserved.
//

import Foundation
import UIKit

//Inherts from uiimageview to override functions, is used to customize the function
class DragImg: UIImageView {
    
    //Create a variable to know where the original position was
    var originalPosition: CGPoint!
    var dropTarget: UIView? //Better put a superclass instead uiimage to reuse!!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //keep the location of the center of the cgpoint
        originalPosition = self.center
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //pass a set of touches, give touch one moves
        if let touch = touches.first { //to prevent crash
            let position = touch.locationInView(self.superview) //grab the position in the view
            self.center = CGPointMake(position.x, position.y)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first, let target = dropTarget { //If there's a touch and there's a drop (2 if let)
            
            let position = touch.locationInView(self.superview?.superview) //to be if is in the character
            if CGRectContainsPoint(target.frame, position){ // If one area contains a point
                NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "onTargetDropped", object: nil))
            }
            
            
        }
        
        self.center = originalPosition
    }
    
}
