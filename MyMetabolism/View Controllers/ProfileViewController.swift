//
//  ProfileViewController.swift
//  MyMetabolism
//
//  Created by Liam Shatzel on 8/23/21.
//  Copyright © 2021 Liam Shatzel. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController{
    
    
    @IBAction func signOutButton_tapped(_ sender: Any) {
        let auth = Auth.auth()
        do {
            try auth.signOut()
            let defaults = UserDefaults.standard
            defaults.set(false, forKey: "isUserSignedIn")
            let loginViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.loginViewController) as! LoginViewController
            self.view.window?.rootViewController = loginViewController
            self.view.window?.makeKeyAndVisible()
        } catch let err {
            print(err)
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
}
