//
//  LoginViewController.swift
//  MyMetabolism
//
//  Created by Liam Shatzel on 7/16/21.
//  Copyright © 2021 Liam Shatzel. All rights reserved.
//

import UIKit
import FirebaseAuth


class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.backgroundColor = UIColor(red: 0.965, green: 0.961, blue: 0.961, alpha: 1).cgColor
        // Do any additional setup after loading the view.
        setupElements()
    }
    
    func setupElements(){
        //Hide error message
        errorLabel.alpha = 0
        
        //Style elements
        Utilities.styleTextField(emailTextField)
        
        Utilities.styleTextField(passwordTextField)
        
        Utilities.styleFilledButton(loginButton)
    }
    
    func validateFields() -> String? {
        
        //Check that fields are filled in
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in:.whitespacesAndNewlines) == ""{
            return "Please fill in all fields."
        }
        return nil
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    

    @IBAction func loginTapped(_ sender: Any) {
        //validate text field
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        }else{
        
        
        //create cleaned versions
        
        let email  = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //sign in user
        Auth.auth().signIn(withEmail: email, password: password) {(result, error) in
            if error != nil {
                self.errorLabel.text  = error!.localizedDescription
                self.errorLabel.alpha = 1
            } else {
                let HomeViewTab: UIViewController? = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController)
                let HomeViewNC = UINavigationController(rootViewController: HomeViewTab!)
                
                let ProfileViewTab: UIViewController? = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.acctViewController)
                let ProfileViewNC = UINavigationController(rootViewController: ProfileViewTab!)
                
                let StatsViewTab: UIViewController? = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.statsViewController)
                let StatsViewNC = UINavigationController(rootViewController: StatsViewTab!)
                
                let tabBarController = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.tabBarController)
                self.tabBarController?.viewControllers = [HomeViewNC, ProfileViewNC, StatsViewNC]
                
                self.view.window?.rootViewController = tabBarController
                self.view.window?.makeKeyAndVisible()
            }

        }
        
    }
}
    func showError(_ message: String){
           errorLabel.text = message
           errorLabel.alpha = 1
       }

    
}
