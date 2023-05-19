//
//  SignUpViewController.swift
//  Foursquare
//
//  Created by Abdelrahman Shehab on 13/05/2023.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func signInButtonClicked(_ sender: Any) {
        if userTextField.text != "" && passwordTextField.text != "" {
            PFUser.logInWithUsername(inBackground: userTextField.text!, password: passwordTextField.text!) { success, error in
                if error != nil {
                    Alert.makeAlert(on: self, titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
            }
        }
    }
    
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        if userTextField.text != "" && passwordTextField.text != "" {
            let user = PFUser()
            user.username = userTextField.text!
            user.password = passwordTextField.text!
            
            user.signUpInBackground { success, error in
                if error != nil {
                    Alert.makeAlert(on: self, titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
            }
        } else {
            Alert.makeAlert(on: self, titleInput: "Error", messageInput: "Username / Password")
        }
    }
    

}

