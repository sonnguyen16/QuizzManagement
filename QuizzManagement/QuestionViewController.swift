//
//  QuestionViewController.swift
//  QuizzManagement
//
//  Created by BVU on 5/29/23.
//  Copyright © 2023 BVU. All rights reserved.
//

import UIKit
import CoreData

class QuestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    var models = [Question]()
    var topic: Topic?
    
    @IBOutlet weak var tableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllItem()
        // Do any additional setup after loading the view.
    }
    
    init?(coder: NSCoder,topic: Topic?){
            self.topic = topic
            super.init(coder: coder)
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    var edit = false
    
    @IBAction func edit(_ sender: Any) {
        edit = !edit
        tableView.setEditing(edit, animated: false)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        title?.append((topic?.title)!)
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as! QuestionTableViewCell
        cell.update(question: model)
        cell.showsReorderControl = true
        cell.imageView?.image = UIImage(named: "drag_icon")
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.deleteItem(item: models[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to : IndexPath) {
           let question = models.remove(at: fromIndexPath.row)
           models.insert(question, at: to.row)
       }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    var selected: IndexPath?
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = indexPath
    }
    
    
    @IBAction func unwindToQuestionTableView(segue: UIStoryboardSegue){
        if segue.identifier == "cancel1"{
                         context.rollback()
            tableView.deselectRow(at: selected!, animated: false)
              }
        guard segue.identifier == "saveUnwind1", let source = segue.source as? AddEditQuestionViewController, let question = source.question else{
            context.rollback()
            return }
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow{
            self.updateItem(item: models[selectedIndexPath.row], text: question.text!, answer1: question.answer1!, answer2: question.answer2!, answer3: question.answer3!, answer4: question.answer4!, correctAnswer: question.correctAnswer!)
        }else{
            createItem()
        }
    }
    
    
    func getAllItem(){
        let fetchRequest: NSFetchRequest<Question> = Question.fetchRequest()

               // Tạo NSPredicate để lọc các đối tượng "Question" theo đối tượng "Topic" cụ thể
        let predicate = NSPredicate(format: "to_one == %@", self.topic!)
               fetchRequest.predicate = predicate
        do{
            models = try context.fetch(fetchRequest)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            print(models)
        }catch{
            
        }
    }
    
    func createItem(){
       
        do{
            try context.save()
            getAllItem()
        }catch{
            
        }
    }
    
    func updateItem(item: Question,text:String, answer1: String, answer2: String, answer3: String, answer4: String, correctAnswer: String){
        item.text = text
        item.answer1 = answer1
        item.answer2 = answer2
        item.answer3 = answer3
        item.answer4 = answer4
        item.correctAnswer = correctAnswer
        do{
            try context.save()
            getAllItem()
        }catch{
            
        }
    }
    
    
    func deleteItem(item: Question){
        context.delete(item)
        do{
            try context.save()
            getAllItem()
        }catch{
            
        }
    }
    
    

    @IBSegueAction func addEditQuestion(_ coder: NSCoder, sender: Any?) -> AddEditQuestionViewController? {
        if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell){
            var question = models[indexPath.row]
            return AddEditQuestionViewController(coder: coder, question: question,topic: self.topic!, context: context)
        }else{
            return AddEditQuestionViewController(coder: coder, question: nil,topic: self.topic!, context: context)
        }
    }
  

}
