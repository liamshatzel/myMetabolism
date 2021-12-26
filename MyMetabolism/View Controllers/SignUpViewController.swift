//
//  SignUpViewController.swift
//  MyMetabolism
//
//  Created by Liam Shatzel on 12/25/21.
//  Copyright © 2021 Liam Shatzel. All rights reserved.
//

var firstname = ""
var lastname = ""
import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.backgroundColor = UIColor(red: 0.965, green: 0.961, blue: 0.961, alpha: 1).cgColor
        
        setUpElements()
    }
    
    func setUpElements(){
        //Hide error label
        errorLabel.alpha = 0
        
        //style elements
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
        
    }
    
    //check and validate input fields
    func validateFields() -> String? {
        //check fields filled in
        if (firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "")
        {
            return "Please fill in all fields."
        }
        
        //check if password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if(Utilities.isPasswordValid(cleanedPassword) == false){
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        return nil
    }
    
    
    @IBAction func signUpTapped(_ sender: Any) {
        //validate fields
        let error = validateFields()
        
        if error != nil {
            showError(error!)
            //show error if there is one
        } else {
            //create cleaned versions of data
            
            firstname = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            lastname = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //create user in firebaseauth
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in if err != nil {
                //there was en error
                self.showError("Error creating user")
            }else{
                //user created sucesfully
                let db = Firestore.firestore()
                
                db.collection("users").document(currentUser()).setData(["firstname" : firstname, "lastname" : lastname, "uid" : result!.user.uid]) { (error) in
                        if(error != nil){
                            self.showError("Error saving user data")
                        }
                    }
                }
            }
        }
        //Signed up user
        transitionToHome()
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome(){
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
