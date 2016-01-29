//
//  choseEventPictureTransitionViewController.swift
//  vite1.1
//
//  Created by Sebastian Misas on 1/26/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class choseEventPictureTransitionViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var galleryIcon: UIButton!
    @IBOutlet weak var galleryLabel: UILabel!
    @IBOutlet weak var cameraIcon: UIButton!
    @IBOutlet weak var cameraLabel: UILabel!
    // create instance of our custom transition manager
    let transitionManager = MenuTransitionManager()
    
    @IBAction func unwindToMainViewController (sender: UIStoryboardSegue){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Uploading images to create event code below
    // -------------------------------------------------------------------
    @IBAction func useGallery(sender: AnyObject) {
    
        var Gallery = UIImagePickerController()
        Gallery.delegate = self
        Gallery.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        Gallery.allowsEditing = true
        self.presentViewController(Gallery, animated: true, completion: nil)

    }
    
    @IBAction func useCamera(sender: AnyObject) {
        // uncomment lines before deployment to use camera
        //        var Camera = UIImagePickerController()
        //        Camera.delegate = self
        //        Camera.sourceType = UIImagePickerControllerSourceType.Camera
        //        Camera.allowsEditing = true
        //        self.presentViewController(Camera, animated: true, completion: nil)
    }
    
    // Global class variable
    var eventImage: UIImage?
    // when image is picked set it equal to the gobal variable above
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        self.eventImage = image
        
        picker.dismissViewControllerAnimated(true, completion: { (finished) -> Void in
            
            self.performSegueWithIdentifier("createEventPage", sender: self)
        })
        
    }
    // If the segue is executed set the global variable "eventImage" to the next view controllers "recivedImage"
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "createEventPage" {
            let destinationViewController = segue.destinationViewController as! CreateEventController
            destinationViewController.recivedImage = self.eventImage
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.transitioningDelegate = self.transitionManager
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
