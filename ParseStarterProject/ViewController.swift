/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func unwindToMainViewController (sender: UIStoryboardSegue){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
 
    @IBOutlet weak var eventInfoContainer: UIScrollView!
    @IBOutlet weak var userProfilePic: UIImageView!
    @IBOutlet weak var eventPicture: UIImageView!
    @IBOutlet weak var event: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let test = PFObject(className: "TestObject")
        test.setObject("Karl", forKey: "Foo")
        test.saveInBackgroundWithBlock { (succeeded, error) -> Void in
            if (succeeded) {
                print("Object Saved")
            } else {
                print("Object did not save")
            }
        }
        
    // making conatiners and images rounded
        userProfilePic.layer.cornerRadius = userProfilePic.frame.size.width/2
        userProfilePic.clipsToBounds = true
        eventInfoContainer.layer.cornerRadius = 15.0
        eventInfoContainer.clipsToBounds = true
        event.layer.cornerRadius = 15.0
        event.clipsToBounds = true

    // code to drag the event
        let gesture = UIPanGestureRecognizer(target: self, action: Selector("wasDragged:"))
        event.addGestureRecognizer(gesture)
        event.userInteractionEnabled = true
        
        
    }


    
// Animation for swiping left and right on event
// ----------------------------------------------------------------------
    func wasDragged(gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translationInView(self.view)
        let event = gesture.view!
        
        event.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: self.view.bounds.height / 2 + translation.y)
        
        let xFromCenter = event.center.x - self.view.bounds.width / 2
        
        let scale = min(100 / abs(xFromCenter), 1)
        
        
        var rotation = CGAffineTransformMakeRotation(xFromCenter / 200)
        
        var stretch = CGAffineTransformScale(rotation, scale, scale)
        
        event.transform = stretch
        
        
        if gesture.state == UIGestureRecognizerState.Ended {
            
            if event.center.x < 100 {
                
                print("Not chosen")
                
            } else if event.center.x > self.view.bounds.width - 100 {
                
                print("Chosen")
                
            }
            
            rotation = CGAffineTransformMakeRotation(0)
            
            stretch = CGAffineTransformScale(rotation, 1, 1)
            
            event.transform = stretch
            
            event.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 1.8)
            
        }
        
    }
// ----------------------------------------------------------------------
// end of swiping annimation code 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
