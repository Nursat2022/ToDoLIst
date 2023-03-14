//
//  TableViewController.swift
//  ToDoList
//
//  Created by Nursat Sakyshev on 13.03.2023.
//

import UIKit

class TableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func pushEditAction(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    
    
    @IBAction func pushAddAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Create New Item", message: nil, preferredStyle: .alert)
        
        alertController.addTextField() { (textField) in
            textField.placeholder = "New Item Name"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        
        let createAction = UIAlertAction(title: "Create", style: .cancel  ) {
            (alert) in
            let newItem = alertController.textFields![0].text
            if newItem != "" {
                addItem(nameItem: newItem!)
                self.tableView.reloadData()
            }
            else {
                let requiredText = UIAlertController(title: "Enter some text", message: nil, preferredStyle: .alert)
                let enterText = UIAlertAction(title: "OK", style: .default)
                requiredText.addAction(enterText)
                self.present(requiredText, animated: true)
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(createAction)
        present(alertController, animated: true)
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        let item = toDoItems[indexPath.row]
        cell.textLabel?.text = item["Name"] as?  String
        
        if (item["isCompleted"] as? Bool) == true {
//            cell.accessoryType = .checkmark
            cell.imageView?.image = UIImage(named: "checkCompleted")?.withTintColor(.green)
        }
        else {
//            cell.accessoryType = .none
            cell.imageView?.image = UIImage(named: "check")
        }
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return true
//    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if changeState(at: indexPath.row) {
            tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(named: "checkCompleted")?.withTintColor(.green)
        }
        else {
            tableView.cellForRow(at: indexPath)?.imageView?.image = UIImage(named: "check")
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        moveItem(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
//        tableView.reloadData()
    }
}
