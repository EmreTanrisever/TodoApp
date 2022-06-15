//
//  ToDoModel.swift
//  ToDoApp
//
//  Created by Emre Tanrısever on 4.06.2022.
//

import Foundation

struct ToDoModel: Codable {
    let task: String
    let description: String
    let date: String
    
    init(task: String, description: String, date: String) {
        self.task = task
        self.description = description
        self.date = date
    }
}
