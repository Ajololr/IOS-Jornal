//
//  ImageDetailsViewController.swift
//  lab
//
//  Created by Ilya Androsav on 2/28/21.
//

import UIKit

class ImageDetailsViewController: UIViewController {
    var currentImageUrl : String! = ""

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        imageView.load(url: URL(string: currentImageUrl)!)
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
