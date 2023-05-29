//
//  ViewController.swift
//  QuizzManagement
//
//  Created by BVU on 5/29/23.
//  Copyright © 2023 BVU. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var models = [Topic]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllItem()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TopicTableViewCell
        cell.update(topic: model)
        cell.showsReorderControl = true
        cell.imageView?.image = UIImage(named: "drag_icon")
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        return .delete
    }
    
    var edit = false
    
    @IBAction func edit(_ sender: Any) {
        edit = !edit
        tableView.setEditing(edit, animated: false)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.deleteItem(item: models[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to : IndexPath) {
        let topic = models.remove(at: fromIndexPath.row)
        models.insert(topic, at: to.row)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func getAllItem(){
        do{
            models = try context.fetch(Topic.fetchRequest())
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
    
    func updateItem(item: Topic, title: String){
        item.title = title
        
        do{
            try context.save()
            getAllItem()
        }catch{
            
        }
    }
    
    
    func deleteItem(item: Topic){
        context.delete(item)
        do{
            try context.save()
            getAllItem()
        }catch{
            
        }
    }
    
    var selected: IndexPath?
       
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           selected = indexPath
       }
    
    @IBAction func unwindToStudentTableView(segue: UIStoryboardSegue){
        if segue.identifier == "cancel"{
                   context.rollback()
            tableView.deselectRow(at: selected!, animated: false)
            
        }
        guard segue.identifier == "saveUnwind", let source = segue.source as? AddEditTopicViewController, let topic = source.topic else{
            return }
        
       
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow{
            self.updateItem(item: models[selectedIndexPath.row], title: topic.title!)
        }else{
            createItem()
        }
    }

    
    @IBSegueAction func addEditTopic(_ coder: NSCoder, sender: Any?) -> AddEditTopicViewController? {
        if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell){
            var topic = models[indexPath.row]
            return AddEditTopicViewController(coder: coder, topic: topic, context: context)
        }else{
            return AddEditTopicViewController(coder: coder, topic: nil, context: context)
        }
    }
    
}

