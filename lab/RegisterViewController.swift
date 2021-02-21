//
//  RegisterViewController.swift
//  lab
//
//  Created by Ilya Androsav on 2/15/21.
//

import UIKit
import FirebaseAuth
import Firebase

let db = Firestore.firestore()
let storage = Storage.storage()
let storageRef = storage.reference()
let imagesRef = storageRef.child("images")
let groupMates = db.collection("group mates");

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var firstNameInput: UITextField!
    @IBOutlet weak var lastNameInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var secondNameInput: UITextField!
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var birthdayInput: UIDatePicker!
    
    @IBAction func imageTap(_ sender: Any) {
        showImagePickerControllerActionSheet()
    }
    @IBAction func createTap(_ sender: Any) {
        label.text = ""
        
        if imageButton.backgroundImage(for: .normal) == nil || passwordInput.text!.isEmpty || emailInput.text!.isEmpty || firstNameInput.text!.isEmpty || secondNameInput.text!.isEmpty || lastNameInput.text!.isEmpty {
            setError("Please, fill all the fields")
            return;
        }
        
        Auth.auth().createUser(withEmail: emailInput.text ?? "", password: passwordInput.text ?? "") { [self](result, error) in
            if let error = error {
                setError(error.localizedDescription)
                  return
            } else {
                if (imageButton.backgroundImage(for: .normal) != nil) {
                    let imageName = UUID().uuidString + ".jpeg";
                    let imageRef = imagesRef.child(imageName);
                    let imageData :Data = imageButton.backgroundImage(for: .normal)!.jpegData(compressionQuality: 1)!
                    imageRef.putData(imageData, metadata: nil) { (metadata, err) in
                        if let err = err {
                            setError("Error saving image: \(err)")
                          return
                        }
                        imageRef.downloadURL { (url, error) in
                          guard let downloadURL = url else {
                            setError("Error saving image: \(String(describing: error))")
                            return
                          }
                            
                           db.collection("group mates").addDocument(data: [
                                "firstName": firstNameInput.text!,
                                "secondName": secondNameInput.text!,
                                "lastName": lastNameInput.text!,
                                "birthday": birthdayInput.date,
                                "email": emailInput.text!,
                                "images": [downloadURL.absoluteString]
                            ]) { err in
                                if let err = err {
                                    setError("Error adding document: \(err)")
                                } else {
                                    passwordInput.text = ""
                                    emailInput.text = ""
                                    firstNameInput.text = ""
                                    secondNameInput.text = ""
                                    lastNameInput.text = ""
                                    imageButton.setBackgroundImage(nil, for: .normal)
                                    setSuccess("Group mate added!")
                                }
                            }
                            
                        }
                      }
                }
                
            }
        }
    }
    
    func setError(_ errorMessage: String) {
        label.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        label.text = errorMessage;
    }
    
    func setSuccess(_ successMessage: String) {
        label.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        label.text = successMessage
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
