//
//  ViewController.swift
//  MyApp
//
//  Created by Admin on 5/24/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController {

    @IBAction func fbLoginPressed(_ sender: Any) {
        let fbLoginManager: FBSDKLoginManager = FBSDKLoginManager()
        
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error == nil {
                if let fbLoginResult = result {
                    if fbLoginResult.grantedPermissions != nil && fbLoginResult.grantedPermissions.contains("email"){
                        self.getFBUserdata()
                    }
                }
            }
        }
        getFBUserdata()
    }
    
    func getFBUserdata(){
        if FBSDKAccessToken.current() != nil{
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id,name,first_name, last_name, picture.type(large), email"]).start(completionHandler: { (cnnection, result, error) in
                if error == nil{
                    print(result ?? "Error in getFBUserdata function")
                }
            })
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        if let accessToken = FBSDKAccessToken.current() {
            print("User is logged in with access token: \(accessToken)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

