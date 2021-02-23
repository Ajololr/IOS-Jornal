//
//  StudentViewController.swift
//  lab
//
//  Created by Ilya Androsav on 2/23/21.
//

import UIKit

class StudentViewController: UIViewController {
    var student: Student?

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
