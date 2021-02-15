//
//  RegisterViewController.swift
//  lab
//
//  Created by Ilya Androsav on 2/15/21.
//

import UIKit

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBAction func imageTap(_ sender: Any) {
        showImagePickerControllerActionSheet()
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
            imageButton.clipsToBounds = true
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImage.image = originalImage
        }
        
        dismiss(animated: true)
    }
}
