//
//  CreateEventController.swift
//  vite1.0
//
//  Created by Sebastian Misas on 1/11/16.
//  Copyright © 2016 Sebastian Misas. All rights reserved.
//

import UIKit

class CreateEventController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextViewDelegate {
    
    var recivedImage: UIImage? = nil
    @IBOutlet weak var eventImageShow: UIImageView!
    @IBOutlet weak var eventDesciption: UITextView!
    @IBOutlet weak var placeholderLabel: UILabel!
    
    @IBAction func createEvent(sender: AnyObject) {
        let postAlert = UIAlertController(title: "Finished creating event?", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        postAlert.addAction(UIAlertAction(title: "Post", style: UIAlertActionStyle.Default, handler: { (actionSheetController) -> Void in
            
    // ADD CODE HERE TO SAVE EVENT TO DATABASE AND DISPLAY ON FEED PAGE
    // -----------------------------------------------------------------
            self.performSegueWithIdentifier("goToFeedPage", sender: self)
        }))
        postAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        self.presentViewController(postAlert, animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        eventImageShow.image = recivedImage
        
        eventDesciption.delegate = self

        placeholderLabel.text = "Describe your event..."
        placeholderLabel.font = UIFont.italicSystemFontOfSize(eventDesciption.font!.pointSize)
        placeholderLabel.sizeToFit()
        placeholderLabel.font.fontWithSize(33)
        eventDesciption.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPointMake(5, eventDesciption.font!.pointSize / 2)
        placeholderLabel.textColor = UIColor(white: 0, alpha: 0.3)
        placeholderLabel.hidden = !eventDesciption.text.isEmpty
    }
    
    func textViewDidChange(textView: UITextView) {
        placeholderLabel.hidden = !textView.text.isEmpty
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
