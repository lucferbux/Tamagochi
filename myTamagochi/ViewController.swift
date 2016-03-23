//
//  ViewController.swift
//  myTamagochi
//
//  Created by lucas fernández on 21/03/16.
//  Copyright © 2016 lucas fernández. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    /*Size class is to set different constraints to different devices
     */
    
    //Outlets
    @IBOutlet weak var monsterImage: MonsterImg!
    
    @IBOutlet weak var heartImage: DragImg!
    
    @IBOutlet weak var foodImage: DragImg!
    
    @IBOutlet weak var penalty1: UIImageView!
    
    @IBOutlet weak var penalty2: UIImageView!
    
    @IBOutlet weak var penalty3: UIImageView!
    
    //Constants and variables
    let DIM_ALPHA: CGFloat = 0.2 // To control the opacity of the images Alpha channel
    let OPAQUE: CGFloat = 1.0
    let MAX_PENALTY = 3
   
    var penalties = 0
    var timer: NSTimer!
    var monsterIsHappy = false
    var currentItem: UInt32 = 0
    
    var musicPlayer: AVAudioPlayer!
    var sfxBite: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodImage.dropTarget = monsterImage //asign drop target to the moster image
        heartImage.dropTarget = monsterImage
        
        penalty1.alpha = DIM_ALPHA
        penalty2.alpha = DIM_ALPHA
        penalty3.alpha = DIM_ALPHA
        foodImage.alpha = DIM_ALPHA
        heartImage.alpha = DIM_ALPHA
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.itemDroppedOnCharacter(_:)), name: "onTargetDropped", object: nil) //selector is the fnction, the itemDroppedOncharacter is with : to indicate they have several arguments, name is the functions in which is called VERY IMPORTANT THE :
        do{
            try musicPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!))
            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
            try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
            
            musicPlayer.prepareToPlay() //to load the audio
            musicPlayer.play()
            
            sfxBite.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxSkull.prepareToPlay()
            sfxDeath.prepareToPlay()
            
        } catch let err as NSError {print(err.debugDescription)}
        
        startFirstTime()
        
    }
    
    func itemDroppedOnCharacter(notif: AnyObject) {
        monsterIsHappy = true
        startTimer()
        
        foodImage.alpha = DIM_ALPHA
        foodImage.userInteractionEnabled = false
        
        heartImage.alpha = DIM_ALPHA
        heartImage.userInteractionEnabled = false
        
        if currentItem == 0 {
            sfxHeart.play()
        }else {
            sfxBite.play()
        }
    }
    
    func startFirstTime() {
        let rand = arc4random_uniform(2)
        
        if rand ==  0 {
            foodImage.alpha = DIM_ALPHA
            foodImage.userInteractionEnabled = false
            
            heartImage.alpha = OPAQUE
            heartImage.userInteractionEnabled = true
        }else{
            heartImage.alpha = DIM_ALPHA
            heartImage.userInteractionEnabled = false
            
            foodImage.alpha = OPAQUE
            foodImage.userInteractionEnabled = true
        }
        
        currentItem = rand
        monsterIsHappy = false
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(ViewController.startTimer), userInfo: nil, repeats: false)
        
    }
    
    func startTimer(){
        if timer != nil{
         timer.invalidate()
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(ViewController.changeGameState), userInfo: nil, repeats: true)
    }
    
    func changeGameState(){
        
        if !monsterIsHappy{
            
        penalties += 1
        sfxSkull.play()
        
        if penalties == 1 {
            penalty1.alpha = OPAQUE
            penalty2.alpha = DIM_ALPHA
        }else if penalties == 2 {
            penalty2.alpha = OPAQUE
            penalty3.alpha = DIM_ALPHA
        }else if penalties == 3 {
            penalty3.alpha = OPAQUE
        }else {
            penalty1.alpha = DIM_ALPHA
            penalty2.alpha = DIM_ALPHA
            penalty3.alpha = DIM_ALPHA

        }
            
            
        }
        
        if penalties >= MAX_PENALTY {
            gameOver()
        }else{
        
        let rand = arc4random_uniform(2)
        
        if rand ==  0 {
            foodImage.alpha = DIM_ALPHA
            foodImage.userInteractionEnabled = false
            
            heartImage.alpha = OPAQUE
            heartImage.userInteractionEnabled = true
        }else{
            heartImage.alpha = DIM_ALPHA
            heartImage.userInteractionEnabled = false
            
            foodImage.alpha = OPAQUE
            foodImage.userInteractionEnabled = true
        }
        
        currentItem = rand
        monsterIsHappy = false
        }
    }
    
    func gameOver(){
        timer.invalidate()
        monsterImage.playDeathAnimation()
        sfxDeath.play()
        foodImage.alpha = DIM_ALPHA
        foodImage.userInteractionEnabled = false
        
        heartImage.alpha = DIM_ALPHA
        heartImage.userInteractionEnabled = false
    }
    
    
//    //class inherited that recognizes a touch
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

