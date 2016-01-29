//
//  LoginController.swift
//  vite1.0
//
//  Created by Sebastian Misas on 1/11/16.
//  Copyright © 2016 Sebastian Misas. All rights reserved.
//
import UIKit
import Parse
import FBSDKCoreKit
import FBSDKLoginKit
import ParseFacebookUtilsV4

class LoginController: UIViewController {
    
    func grabUserData() {
        FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields":"first_name, last_name, picture.type(large)"]).startWithCompletionHandler { (connection, result, error) -> Void in
            let userFirstName: String = (result.objectForKey("first_name") as? String)!
            let userLastName: String = (result.objectForKey("last_name") as? String)!
            let userPictureURL: String = (result.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as? String)!
            print("User: " + userFirstName + "" + userLastName)
        }
    }
    
    

    @IBAction func LoginButton(sender: AnyObject) {
        // saving the user to Parse when he logs in faceboook with access to his public info.
        let permissions = [ "public_profile", "email", "user_friends" ]
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions,  block: {  (user: PFUser?, error: NSError?) -> Void in
            if (error != nil) {
                print("error")
            }
            if let user = user {
                if user.isNew {
                    print("User signed up and logged in through Facebook!")
                    self.grabUserData()
                    self.performSegueWithIdentifier("ShowMainController", sender: self)
                }
                else {
                    print("User logged in through Facebook!")
                    self.performSegueWithIdentifier("ShowMainController", sender: self)
                }
            }
            else {
                print("Uh oh. The user cancelled the Facebook login.")
            }
        })

    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        // if user is logged in already go to main page else show FB login button
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            print("User already logged in")
            self.performSegueWithIdentifier("ShowMainController", sender: self)
        }
        

    }

    @IBOutlet weak var webViewBG: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//     The code below is to use the gif as a motion background.

        let filePath = NSBundle.mainBundle().pathForResource("giphy", ofType: "gif")
        let gif = NSData(contentsOfFile: filePath!)
        webViewBG.loadData(gif!, MIMEType: "image/gif", textEncodingName: String(), baseURL: NSURL())
        webViewBG.userInteractionEnabled = false;
        //loginButton.delegate = self

    
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


