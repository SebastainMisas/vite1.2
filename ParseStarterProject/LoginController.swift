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

class LoginController: UIViewController, FBSDKLoginButtonDelegate {
    
    func grabUserData() {
        FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields":"first_name, last_name, picture.type(large)"]).startWithCompletionHandler { (connection, result, error) -> Void in
            let userFirstName: String = (result.objectForKey("first_name") as? String)!
            let userLastName: String = (result.objectForKey("last_name") as? String)!
            let userPictureURL: String = (result.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as? String)!
            print("User: " + userFirstName + "" + userLastName)
        }
    }
    

    @IBAction func LoginButton(sender: AnyObject) {

        let permissions = [ "public_profile", "email", "user_friends" ]
        //[PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions)]
        
        
        let fbLogin:FBSDKLoginManager = PFFacebookUtils.facebookLoginManager()//FBSDKLoginManager.init()
        fbLogin.loginBehavior = FBSDKLoginBehavior.SystemAccount;


        fbLogin.logInWithReadPermissions(permissions, fromViewController: self, handler: { (result, error) -> Void in
            
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result
                if(fbloginresult.grantedPermissions != nil && fbloginresult.grantedPermissions.contains("email"))
                {
                    self.grabUserData()
                    //self.fetchUserInfo()
                    //fbLogin.logOut()
                }
            }
        })
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
//        let loginView : FBSDKLoginButton = FBSDKLoginButton()
//        self.view.addSubview(loginView)
//        loginView.center = self.view.center
//        loginView.readPermissions = ["public_profile", "email", "user_friends"]
//        loginView.delegate = self
        
        
        // If we have an access token, then let's display some info
        FBSDKProfile.enableUpdatesOnAccessTokenChange(true)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onTokenUpdated:", name:FBSDKAccessTokenDidChangeNotification, object: nil)
    
    }
    
    // in a LoginViewController.swift
    func onTokenUpdated(notification: NSNotification) {
        if ((FBSDKAccessToken.currentAccessToken()) != nil) {
            print("token is not nil ")
            self.grabUserData()
        } else {
            print("token is nil")
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            self.performSegueWithIdentifier("ShowMainController", sender: self)
            // Display current FB premissions
            print (FBSDKAccessToken.currentAccessToken().permissions)
            
            // Since we already logged in we can display the user datea and taggable friend data.
            
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print(result)
    }
    
    /*!
    @abstract Sent to the delegate when the button was used to logout.
    @param loginButton The button that was clicked.
    */
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("inDidLogOut")
        
    }
}


