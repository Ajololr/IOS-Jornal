//
//  GalleryCollectionViewController.swift
//  lab
//
//  Created by Ilya Androsav on 2/28/21.
//

import UIKit

private let reuseIdentifier = "Cell"

class GalleryCollectionViewController: UICollectionViewController {
    var studentImages : [String] = []
    var studentId : String = ""
    
    @IBAction func addImageTap(_ sender: Any) {
        showImagePickerController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        super.prepare(for: segue, sender: sender)
        
        guard let galleryImageController = segue.destination as? ImageDetailsViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        
       guard let selectedImageCell = sender as? GalleryImageCollectionViewCell else {
        fatalError("Unexpected sender: \(String(describing: sender))")
       }
        
       guard let indexPath = collectionView.indexPath(for: selectedImageCell) else {
           fatalError("The selected cell is not being displayed by the collection view")
       }
        
        galleryImageController.currentImageUrl = studentImages[indexPath.item]
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return studentImages.count + (3 - studentImages.count % 3)
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Configure the cell
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as? GalleryImageCollectionViewCell else {
            fatalError("The dequeued cell is not an instance of GalleryImageCollectionViewCell.")
        }
        if (indexPath.item < studentImages.count) {
            if let url = URL(string: studentImages[indexPath.item]) {
                cell.imageView?.load(url: url)
            }
        }
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension GalleryCollectionViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    func showImagePickerController() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.mediaTypes = ["public.image"]
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            let imageName = UUID().uuidString + ".jpeg";
            let imageRef = imagesRef.child(imageName);
            let imageData :Data = editedImage.jpegData(compressionQuality: 0.5)!
            imageRef.putData(imageData, metadata: nil) { (metadata, err) in
                if let err = err {
                    print("Error saving image: \(err)")
                  return
                }
                imageRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                      print("Error saving image: \(String(describing: error))")
                      return
                    }
                    self.studentImages += [downloadURL.absoluteString]
                    groupMates.document(self.studentId).setData([ "images": self.studentImages ], merge: true) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        }
                    }
                }
            }
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let imageName = UUID().uuidString + ".jpeg";
            let imageRef = imagesRef.child(imageName);
            let imageData :Data = originalImage.jpegData(compressionQuality: 0.5)!
            imageRef.putData(imageData, metadata: nil) { (metadata, err) in
                if let err = err {
                    print("Error saving image: \(err)")
                  return
                }
                imageRef.downloadURL { (url, error) in
                    guard let downloadURL = url else {
                      print("Error saving image: \(String(describing: error))")
                      return
                    }
                    self.studentImages += [downloadURL.absoluteString]
                    groupMates.document(self.studentId).setData([ "images": self.studentImages ], merge: true) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        }
                    }
                }
            }
        }
        
        self.collectionView.reloadData()
        
        dismiss(animated: true)
    }
}

extension GalleryCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 3 - 2, height: UIScreen.main.bounds.width / 3 - 2)
    }
}
