//
//  settings.swift
//  vite1.1
//
//  Created by Sebastian Misas on 1/25/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import TNImageSliderViewController

class profileTab: UIViewController {
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
    }
    
    let transitionManager = TransitionManager()
    var imageSliderVC:TNImageSliderViewController!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if( segue.identifier == "seg_imageSlider" ){
            
            imageSliderVC = segue.destinationViewController as! TNImageSliderViewController
            
        }
        // this gets a reference to the screen that we're about to transition to
        let toViewController = segue.destinationViewController as UIViewController
        
        // instead of using the default transition animation, we'll ask
        // the segue to use our custom TransitionManager object to manage the transition animation
        toViewController.transitioningDelegate = self.transitionManager
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image1 = UIImage(named: "12294663_10203804687677120_2383926010236257492_n")
        let image2 = UIImage(named: "boat-party")
        let image3 = UIImage(named: "sparkled-mci-party-bus-interior-limo-bus-dfw")
        
        if let image1 = image1, let image2 = image2, let image3 = image3 {
            
            // 1. Set the image array with UIImage objects
            imageSliderVC.images = [image1, image2, image3]
            
            // 2. If you want, you can set some options
            var options = TNImageSliderViewOptions()
            options.pageControlHidden = false
            options.scrollDirection = .Horizontal
            options.pageControlCurrentIndicatorTintColor = UIColor.yellowColor()
            
            
            imageSliderVC.options = options
            
        }else {
            
            print("[ViewController] Could not find one of the images in the image catalog")
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}

