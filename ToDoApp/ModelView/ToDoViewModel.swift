//
//  ToDoViewModel.swift
//  ToDoApp
//
//  Created by Emre Tanrısever on 4.06.2022.
//

import Foundation

class ToDoViewModel {

    private let userDefaultsKey = "Deneme"
    private var array = [ToDoModel]()
    
    func add(data: [ToDoModel]) {
        array = readTasks()!
        array.append(data[0])
        if !array.isEmpty {
            if let newData = try? JSONEncoder().encode(array) {
                UserDefaults.standard.set(newData, forKey: userDefaultsKey)
            }
        } else {
            if let newData = try? JSONEncoder().encode(array) {
                UserDefaults.standard.set(newData, forKey: userDefaultsKey)
                
            }
        }
    }
    
    func update(data: ToDoModel, index: Int) {
        guard let savedToDos = readTasks() else { return }
        array = savedToDos
        array.remove(at: index)
        array.insert(data, at: index)
        addNewToDo(data: array)
    }
    
    func delete(index: Int) {
        guard let savedToDos = readTasks() else { return }
        array = savedToDos
        array.remove(at: index)
        addNewToDo(data: array)
    }
    
    func addNewToDo(data: [ToDoModel]) {
        if let newData = try? JSONEncoder().encode(data) {
            UserDefaults.standard.set(newData, forKey: userDefaultsKey)
        }
    }
    
    func readTasks() -> [ToDoModel]? {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey), let savedItems = try? JSONDecoder().decode([ToDoModel].self, from: data) else { return [ToDoModel]() }
        return savedItems
    }
 
    
    func countData() -> Int? {
        if let data = readTasks() {
            return data.count
        }
        return 0
    }
    
    func returnData() -> [ToDoModel]? {
        if let items = readTasks() {
            return items
        }
        return [ToDoModel]()
    }
}
