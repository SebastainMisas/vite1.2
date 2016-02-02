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
        // saving the user to Parse when he logs in faceboook with access to his public info.
        let permissions = [ "email"]//"public_profile", "email", "user_friends" ]
        let fbLogin:FBSDKLoginManager = PFFacebookUtils.facebookLoginManager();//FBSDKLoginManager.init()
        fbLogin.loginBehavior = FBSDKLoginBehavior.SystemAccount;
//        fbLogin.logInWithReadPermissions(permissions, handler: block :)
//        //fbLogin.logInInBackgroundWithReadPermissions(permissions,  block: {  (user: PFUser?, error: NSError?) -> Void in
//            if (error != nil) {
//                print("error")
//            }
//            if let user = user {
//                if user.isNew {
//                    print("User signed up and logged in through Facebook!")
//                    self.grabUserData()
//                    self.performSegueWithIdentifier("ShowMainController", sender: self)
//                }
//                else {
//                    print("User logged in through Facebook!")
//                    self.performSegueWithIdentifier("ShowMainController", sender: self)
//                }
//            }
//            else {
//                print("Uh oh. The user cancelled the Facebook login.")
//            }
//        })

        fbLogin.logInWithReadPermissions(permissions, fromViewController: self, handler: { (result, error) -> Void in
            
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result
                if(fbloginresult.grantedPermissions != nil && fbloginresult.grantedPermissions.contains("email"))
                {
                    self.fetchUserInfo()
                    //fbLogin.logOut()
                }
            }
        })
    }
    func fetchUserInfo(){
        if((FBSDKAccessToken.currentAccessToken()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                if (error == nil){
                    print(result)
                    result.valueForKey("email") as! String
                    result.valueForKey("id") as! String
                    result.valueForKey("name") as! String
                    result.valueForKey("first_name") as! String
                    result.valueForKey("last_name") as! String
                }
            })
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
        let loginView : FBSDKLoginButton = FBSDKLoginButton()
        self.view.addSubview(loginView)
        loginView.center = self.view.center
        loginView.readPermissions = ["public_profile", "email", "user_friends"]
        loginView.delegate = self
        
        // If we have an access token, then let's display some info
        FBSDKProfile.enableUpdatesOnAccessTokenChange(true)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onTokenUpdated:", name:FBSDKAccessTokenDidChangeNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onProfileUpdated:", name:FBSDKProfileDidChangeNotification, object: nil)
    
    }
    
    // in a LoginViewController.swift
    func onTokenUpdated(notification: NSNotification) {
        if ((FBSDKAccessToken.currentAccessToken()) != nil) {
            print("token is not nil ")
        } else {
            print("token is nil")
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            // Display current FB premissions
            print (FBSDKAccessToken.currentAccessToken().permissions)
            
            // Since we already logged in we can display the user datea and taggable friend data.
            self.showUserData()
            self.showFriendData()
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "id, name, gender, first_name, last_name, locale, email"])
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                let userName : NSString = result.valueForKey("name") as! NSString
                print("User Name is: \(userName)")
                
                if let userEmail : NSString = result.valueForKey("email") as? NSString {
                    print("User Email is: \(userEmail)")
                }
            }
        })
    }
    
    func showFriendData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me/taggable_friends?limit=999", parameters: ["fields" : "name"])
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                if let friends : NSArray = result.valueForKey("data") as? NSArray{
                    var i = 1
                    for obj in friends {
                        if let name = obj["name"] as? String {
                            print("\(i) " + name)
                            i++
                        }
                    }
                }
            }
        })
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


