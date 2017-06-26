//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Jessica Yeh on 6/26/17.
//  Copyright © 2017 Jessica Yeh. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    let emptySignupAlertController = UIAlertController(title: "Error", message: "Username or Password field is empty", preferredStyle: .alert)
    let errorAlertController = UIAlertController(title: "Error", message: "Issue occurred during Signup or Login", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        emptySignupAlertController.addAction(OKAction)
        
        let tryAgainAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        errorAlertController.addAction(tryAgainAction)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didSignUp(_ sender: Any) {
        let newUser = PFUser()
        
        newUser.username = self.username.text
        newUser.password = self.password.text
        
        if (self.username.text?.isEmpty)! || (self.password.text?.isEmpty)! {
            present(emptySignupAlertController, animated: true) {}
        } else {
            newUser.signUpInBackground { (success: Bool, error: Error?) in
                if let error = error {
                    print(error.localizedDescription)
                    self.present(self.errorAlertController, animated: true) {}
                } else {
                    print("User Registered successfully")
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                }
            }
        }
    }

    @IBAction func didLogin(_ sender: Any) {
        let username = self.username.text ?? ""
        let password = self.password.text ?? ""
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User log in failed: \(error.localizedDescription)")
            } else {
                print("User logged in successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
