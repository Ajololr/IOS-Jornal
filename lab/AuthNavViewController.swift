//
//  AuthNavViewController.swift
//  lab
//
//  Created by Ilya Androsav on 2/14/21.
//

import UIKit
import Firebase
import FirebaseAuth
import LanguageManager_iOS

class AuthNavViewController: UIViewController {

    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        errorLabel.text = ""
        
        if emailInput.text == "" || passwordInput.text == "" {
            errorLabel.text = "Please, fill all the fields"
        }
        
        Auth.auth().signIn(withEmail: emailInput.text!, password: passwordInput.text!) { [self]result, err in
            if let err = err {
                errorLabel.text = err.localizedDescription
            } else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTapBarNavController")
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
            }
        }

    }

}
