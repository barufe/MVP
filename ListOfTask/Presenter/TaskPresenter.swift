//
//  TaskPresenter.swift
//  ListOfTask
//
//  Created by Germain Seijas on 29/01/24.
//

import Foundation

protocol UI: AnyObject {
    func update()
}


final class TaskPresenter{
    weak var delegate: UI?
    var tasks: [Task] = []
    
    private var taskDataBase = TaskDataBase()
    
    func create(task: String) {
        guard !task.isEmpty else {
            return
        }
        let newTask: Task = .init(text: task, isFavorite: false)
        tasks = taskDataBase.create(task: newTask)
        delegate?.update()
    }
    func updateFavorite(taskId: UUID) {
        tasks = taskDataBase.updateFavorite(taskId: taskId)
        delegate?.update()
    }
    func removeTasks(taskId: UUID){
        tasks = taskDataBase.remove(taskId: taskId)
        delegate?.update()
    }
    @objc func removeAllTasks(){
        tasks = taskDataBase.removeAll()
        delegate?.update()
    }
}


