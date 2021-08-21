//
//  HomeViewController.swift
//  MyMetabolism
//
//  Created by Liam Shatzel on 7/16/21.
//  Copyright © 2021 Liam Shatzel. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.layer.backgroundColor = UIColor(red: 0.965, green: 0.961, blue: 0.961, alpha: 1).cgColor
    }
    
    @IBAction func logOutButton_Tapped(_ sender: Any) {
        let auth = Auth.auth()
        do {
            try auth.signOut()
            let loginViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.loginViewController) as? LoginViewController
            self.view.window?.rootViewController = loginViewController
            self.view.window?.makeKeyAndVisible()
        } catch let signOutError {
            print("Error")
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
