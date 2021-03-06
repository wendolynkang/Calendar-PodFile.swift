//
//  TasksTableViewController.swift
//  Calendar
//
//  Created by Wendolyn Kang on 30/10/18.
//  Copyright © 2018 Wendolyn Kang. All rights reserved.
//

import UIKit
import Firebase

class TasksTableViewController: UITableViewController {
    
    var tasks: [Task] = []
    let db = Database.database().reference(withPath: "tasks")
    let onlineDb = Database.database().reference(withPath: "online")
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                self.user = User(id: user.uid, email:  user.email!)
                let userRef = self.onlineDb.child(self.user.id) 
                userRef.setValue(self.user.email)
                userRef.onDisconnectRemoveValue()
            }
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        db.queryOrdered(byChild: "completed").observe(.value) { (snapshot) in
            
            var newTasks: [Task] = []
            
            print(snapshot)
            // Now to update newTasks with all the children of snapshot
            
            for childSnapshot in snapshot.children {
                if let childSnapshot = childSnapshot as? DataSnapshot,
                    let taskDict = childSnapshot.value as? [String: AnyObject],
                    let uuid = taskDict["uuid"] as? String,
                    let name = taskDict["name"] as? String,
                    let completed = taskDict["completed"] as? Bool,
                    let addedByUser = taskDict["addedBy"] as? String {
                    let newTask = Task(uuid: uuid, name: name, completed: completed, addedBy: addedByUser, ref: childSnapshot.ref)
                    newTasks.append(newTask)
                }
            }
            
            self.tasks = newTasks
            self.tableView.reloadData()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }
    

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
    
        cell.textLabel?.text = tasks[indexPath.row].name
        cell.detailTextLabel?.text = tasks[indexPath.row].addedBy
        
        if (tasks[indexPath.row].completed) {
            cell.textLabel?.textColor = .gray
            cell.detailTextLabel?.textColor = .gray
            cell.accessoryType = .checkmark
        } else {
            cell.textLabel?.textColor = .black
            cell.detailTextLabel?.textColor = .black
            cell.accessoryType = .none
        }
        return cell
    }    
    
    @IBAction func addTask(_ sender: Any) {
        let alert = UIAlertController(title: "Add task", message: "", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Add", style: .default) { (_) in
            let textField = alert.textFields![0]
            let task = Task(uuid: UUID().uuidString, name: textField.text ?? "", completed: true, addedBy: "someone@gmail.com", ref: nil)
            
            let taskRef = self.db.child(task.uuid)
            taskRef.setValue(task.toDictionary())
          
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addTextField()
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let task = tasks[indexPath.row]
        let completed = !task.completed
        task.ref?.updateChildValues(["completed" : completed])

    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasks[indexPath.row].ref?.removeValue()
           
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


