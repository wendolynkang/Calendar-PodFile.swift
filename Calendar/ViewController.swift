//
//  ViewController.swift
//  Calendar
//
//  Created by Wendolyn Kang on 24/10/18.
//  Copyright © 2018 Wendolyn Kang. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func signupButtonPressed(_ sender: Any) {
            let alert = UIAlertController(title: "Register", message: "", preferredStyle: .alert)
        
            let saveAction = UIAlertAction(title: "Save", style: .default){ (_) in
                
                let emailField = alert.textFields![0]
                let passwordField = alert.textFields![1]
                
                Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { (user, error) in
                    if error == nil {
                        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!)
                    }
                }
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        alert.addTextField {textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Enter your password"
        }
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}

