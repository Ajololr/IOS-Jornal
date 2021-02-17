//
//  RegisterViewController.swift
//  lab
//
//  Created by Ilya Androsav on 2/15/21.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    @IBAction func imageTap(_ sender: Any) {
        showImagePickerControllerActionSheet()
    }
    @IBAction func createTap(_ sender: Any) {
        
        
        Auth.auth().createUser(withEmail: emailInput.text ?? "", password: passwordInput.text ?? "") {(result, error) in
            if let error = error {
                  print(error.localizedDescription)
                  return
                }
        }
    }
    
}

extension RegisterViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func showImagePickerControllerActionSheet() {
        let photoLibAction = UIAlertAction( title: "Choose from library", style: .default ) {
            (action) in self.showImagePickerController(sourceType: .photoLibrary)
        }
        let cameraAction = UIAlertAction( title: "Take from camera", style: .default ) {
            (action) in self.showImagePickerController(sourceType: .camera)
        }
        let cancelAction = UIAlertAction( title: "Cancel", style: .cancel, handler: nil )
        AlertService.showAlert(style: .actionSheet, title: "Choose your image", message: nil, actions: [photoLibAction, cameraAction, cancelAction], completion: nil)
    }
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageButton.setBackgroundImage(editedImage, for:  UIControl.State.normal)
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageButton.setBackgroundImage(originalImage, for:  UIControl.State.normal)
        }
        imageButton.clipsToBounds = true
        
        dismiss(animated: true)
    }
}
