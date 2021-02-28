//
//  StudentTableViewController.swift
//  lab
//
//  Created by Ilya Androsav on 2/21/21.
//

import UIKit
import Firebase
import FirebaseFirestore
import os.log

class Student {
    var id : String
    var firstName : String
    var lastName : String
    var secondName : String
    var imageUrl : String
    var birthday : Date
    var videoUrl : String
    var longitude: String
    var latitude: String
    
    init(id: String, firstName:String, lastName:String, secondName:String, imageUrl:String, birthday:Date, videoUrl: String, longitude: String, latitude: String) {
        self.id = id
        self.birthday = birthday
        self.firstName = firstName
        self.secondName = secondName
        self.lastName = lastName
        self.imageUrl = imageUrl
        self.videoUrl = videoUrl
        self.latitude = latitude
        self.longitude = longitude
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

class StudentTableViewController: UITableViewController {
    //MARK: Properties
    
    var students = [Student]()
    
    //MARK: Private Methods
    
    public func loadStudents() {
        students = [Student]()
        groupMates.getDocuments() { [self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let a = document.get("images")
                    var b: [String] = []
                    if (a != nil) {
                         b = a as! [String]
                    }
                    
                    let postTimestamp = document.get("birthday") as! Timestamp;
                    let birthday = postTimestamp.dateValue();
                    
                    let student = Student(id: document.documentID, firstName: document.get("firstName") as! String, lastName: document.get("lastName") as! String, secondName: document.get("secondName") as! String, imageUrl: b.isEmpty ? "" : b[0], birthday: birthday, videoUrl: document.get("videoUrl") as! String, longitude: document.get("longitude") as! String, latitude: document.get("latitude") as! String)
                    self.students += [student]
                }
                self.tableView.reloadData()
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadStudents()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 0);

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return students.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StudentTableViewCell", for: indexPath) as? StudentTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }

        let student = students[indexPath.row]
        
        cell.nameLabel.text = student.firstName + " " + student.lastName + " " + student.secondName
        if let url = URL(string: student.imageUrl) {
            print(url)
            cell.imageView?.load(url: url)
//            self.tableView.reloadData()
        } else {
            cell.imageView?.image = UIImage(named: "user")
        }
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let studentDetailViewController = segue.destination as? StudentViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
         
        guard let selectedStudentCell = sender as? StudentTableViewCell else {
            fatalError("Unexpected sender: \(sender)")
        }
         
        guard let indexPath = tableView.indexPath(for: selectedStudentCell) else {
            fatalError("The selected cell is not being displayed by the table")
        }
         
        let selectedStudent = students[indexPath.row]
        studentDetailViewController.student = selectedStudent
    }

}
