//
//  ProfileViewController.swift
//  lab
//
//  Created by Ilya Androsav on 2/14/21.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var themeMode: UISegmentedControl!
    @IBOutlet weak var fontSizeSelector: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logout(_ sender: Any) {
        // ...
            // after user has successfully logged out
      
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginNavController = storyboard.instantiateViewController(identifier: "AuthNavController")

        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginNavController)
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
