//
//  Model.swift
//  ToDoList
//
//  Created by Nursat Sakyshev on 13.03.2023.
//

import Foundation

var toDoItems: [[String: Any]] {
    set {
        UserDefaults.standard.set(newValue, forKey: "ToDoDataKey")
        UserDefaults.standard.synchronize()
    }
    
    get {
        if let array = UserDefaults.standard.array(forKey: "ToDoDataKey") as? [[String: Any]] {
            return array
        }
        else {
            return []
        }
    }
}

func addItem(nameItem: String, isCompleted: Bool = false) {
    toDoItems.append(["Name" : nameItem, "isCompleted" : false]) 
}

func removeItem(at Index: Int) {
    toDoItems.remove(at: Index)
}

//func moveItem(fromIndex: Int, toIndex: Int ) {
//    let from = toDoItems[fromIndex]
//    toDoItems.remove(at: fromIndex)
//    toDoItems.insert(from, at: toIndex)
//}

func changeState(at item: Int) -> Bool {
    toDoItems[item]["isCompleted"] = !(toDoItems[item]["isCompleted"] as! Bool)
    return toDoItems[item]["isCompleted"] as! Bool
}

