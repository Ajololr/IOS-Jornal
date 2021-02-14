//
//  ViewController.swift
//  lab
//
//  Created by Ilya Androsav on 2/2/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didtapButton()  {
        let vc = UIViewController();
        vc.view.backgroundColor = .red;
        
        navigationController?.pushViewController(vc, animated: true);
    }

}

