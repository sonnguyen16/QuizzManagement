//
//  AddEditTopicViewController.swift
//  QuizzManagement
//
//  Created by BVU on 5/29/23.
//  Copyright © 2023 BVU. All rights reserved.
//

import UIKit
import CoreData

class AddEditTopicViewController: UIViewController {

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var viewQuestion: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let topic = topic{
            title = "Edit Topic"
            titleTextField.text = topic.title
            
        }else{
            title = "Add Topic"
            self.topic = Topic(context: self.context)
            viewQuestion.isEnabled = false
        }
        updateButtonSaveStatus()
    }
    
    func updateButtonSaveStatus(){
        if titleTextField.text!.isEmpty{
            saveButton.isEnabled = false
        }else{
            saveButton.isEnabled = true
        }
    }
  
    let context: NSManagedObjectContext
    
    var topic: Topic?

    init?(coder: NSCoder,topic: Topic?, context: NSManagedObjectContext){
         self.topic = topic
         self.context = context
         super.init(coder: coder)
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

    
    @IBAction func checkText(_ sender: UITextField) {
        updateButtonSaveStatus()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         guard segue.identifier == "saveUnwind" else{
             return
         }
         
   
        guard let title = titleTextField.text else { return }
         
         
         topic?.title = title
         
     }

    @IBSegueAction func toQuestionList(_ coder: NSCoder, sender: Any?) -> QuestionViewController? {
        return QuestionViewController(coder: coder, topic: topic)
    }
    
    @IBAction func unwindToEditTopicView(segue: UIStoryboardSegue){
        
        
    }
}
