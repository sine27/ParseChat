//
//  LoginViewController.swift
//  Parse Chat
//
//  Created by Shayin Feng on 2/23/17.
//  Copyright © 2017 Shayin Feng. All rights reserved.
//

import UIKit
import Parse

var currentuser = PFUser()

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!

    @IBAction func signupButtonTapped(_ sender: Any) {
        signUp()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        login()
    }
    
    
    func signUp() {
        
        currentuser.username = emailTextField.text
        currentuser.password = passwordTextField.text
        currentuser.email = "feng87@purdue.edu"
        
        currentuser.signUpInBackground { (success, error) in
            if let error = error {
                print("Signup: Error >>> \(error.localizedDescription)")
                // Show the errorString somewhere and let the user try again.
                Helper.alertMessage("Sign Up", userMessage: "Sign up failed", action: { (action) in }, sender: self)
            } else {
                // Hooray! Let them use the app now.
                Helper.alertMessage("Sign Up", userMessage: "Sign up successfully", action: { (action) in
                    self.performSegue(withIdentifier: "loginToStart", sender: self)
                }, sender: self)
            }
        }
    }
    
    func login() {
        var user = PFUser()
        let username = emailTextField.text
        let password = passwordTextField.text
        // let email = emailTextField.text
        
        // Validate the text fields
        if username == "" || username == nil {
            Helper.alertMessage("Login", userMessage: "Please enter the username", action: { (action) in }, sender: self)
            
        } else if password == "" || password == nil{
            Helper.alertMessage("Login", userMessage: "Please enter the password", action: { (action) in }, sender: self)
            
        } else {
            // Run a spinner to show a task in progress
            
            // Send a request to login
            PFUser.logInWithUsername(inBackground: username!, password: password!, block: { (user, error) -> Void in
                
                if ((user) != nil) {
                    
                    currentuser = user!
                    
                    Helper.alertMessage("Login", userMessage: "Success", action: { (action) in
                        let viewController: UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "chatVC") as! ChatViewController
                        self.present(viewController, animated: true, completion: nil)
                    }, sender: self)
                    
                } else {
                    Helper.alertMessage("Login", userMessage: "Failed", action: { (action) in }, sender: self)
                }
            })
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
