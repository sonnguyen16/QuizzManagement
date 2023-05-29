//
//  AddEditQuestionViewController.swift
//  QuizzManagement
//
//  Created by BVU on 5/29/23.
//  Copyright © 2023 BVU. All rights reserved.
//

import UIKit
import CoreData

class AddEditQuestionViewController: UIViewController {
    
    let context: NSManagedObjectContext
    
    var question: Question?
    var topic: Topic?

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var answer1TextField: UITextField!
    @IBOutlet weak var answer2TextField: UITextField!
    @IBOutlet weak var answer3TextField: UITextField!
    @IBOutlet weak var answer4TextField: UITextField!
    @IBOutlet weak var correctAnswerTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateStatusSaveButton()
        if let question = question{
            title = "Edit Question"
            textField.text = question.text
            answer1TextField.text = question.answer1
            answer2TextField.text = question.answer2
            answer3TextField.text = question.answer3
            answer4TextField.text = question.answer4
            correctAnswerTextField.text = question.correctAnswer
        }else{
            title = "Add Question"
            self.question = Question(context: self.context)
        }
    }
    
    init?(coder: NSCoder,question: Question?,topic: Topic, context: NSManagedObjectContext){
         self.question = question
         self.topic = topic
         self.context = context
         super.init(coder: coder)
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
    func updateStatusSaveButton()  {
        if textField.text!.isEmpty || answer1TextField.text!.isEmpty || answer2TextField.text!.isEmpty || answer3TextField.text!.isEmpty || answer4TextField.text!.isEmpty || correctAnswerTextField.text!.isEmpty{
            saveButton.isEnabled = false
        }else{
            saveButton.isEnabled = true
        }
    }
    @IBAction func checkText(_ sender: UITextField) {
        updateStatusSaveButton()
    }
    
    @IBAction func checkText1(_ sender: Any) {
        updateStatusSaveButton()
    }
    
    @IBAction func checkText2(_ sender: Any) {
        updateStatusSaveButton()
    }
    
    @IBAction func checkText3(_ sender: Any) {
        updateStatusSaveButton()
    }
    
    
    @IBAction func checkText4(_ sender: Any) {
        updateStatusSaveButton()
    }
    
    @IBAction func checkText5(_ sender: Any) {
        updateStatusSaveButton()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         guard segue.identifier == "saveUnwind1" else{
             return
         }
        
        question!.text = textField.text
        question!.answer1 = answer1TextField.text
        question!.answer2 = answer2TextField.text
        question!.answer3 = answer3TextField.text
        question!.answer4 = answer4TextField.text
        question!.correctAnswer = correctAnswerTextField.text
        question!.to_one = self.topic
        
     }
   
}
