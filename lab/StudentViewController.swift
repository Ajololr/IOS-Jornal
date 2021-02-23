//
//  StudentViewController.swift
//  lab
//
//  Created by Ilya Androsav on 2/23/21.
//

import UIKit
import AVKit

class StudentViewController: UIViewController {
    var student: Student?
    var videoURL: NSURL?

    @IBOutlet weak var firstNameInput: UITextField!
    @IBOutlet weak var secondNameInput: UITextField!
    @IBOutlet weak var lastNameInput: UITextField!
    @IBOutlet weak var birthdayInput: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input through delegate callbacks.
        // Set up views if editing an existing Meal.
        if let student = student {
            navigationItem.title = student.firstName + " " + student.lastName
            firstNameInput.text = student.firstName
            secondNameInput.text = student.secondName
            lastNameInput.text = student.lastName
            birthdayInput.date = student.birthday
        }
        
    }
    
    @IBAction func uploadVideoTap(_ sender: Any) {
        showVideoPickerControllerActionSheet()
    }
    
    @IBAction func watchVideoTap(_ sender: Any) {
        let player = AVPlayer(url: videoURL! as URL)

          let playerViewController = AVPlayerViewController()
          playerViewController.player = player

        present(playerViewController, animated: true) {
            playerViewController.player!.play()
          }
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

extension StudentViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func showVideoPickerControllerActionSheet() {
        let photoLibAction = UIAlertAction( title: "Choose from library", style: .default ) {
            (action) in self.showImagePickerController(sourceType: .photoLibrary)
        }
        let cameraAction = UIAlertAction( title: "Take from camera", style: .default ) {
            (action) in self.showImagePickerController(sourceType: .camera)
        }
        let cancelAction = UIAlertAction( title: "Cancel", style: .cancel, handler: nil )
        AlertService.showAlert(style: .actionSheet, title: "Choose your video", message: nil, actions: [photoLibAction, cameraAction, cancelAction], completion: nil)
    }
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = ["public.movie"]
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? NSURL
        print(videoURL!)
        
        dismiss(animated: true)
    }
}
