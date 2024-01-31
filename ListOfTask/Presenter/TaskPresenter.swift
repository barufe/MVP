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
    
    // creamos una variable del tipo de modelo que usaremos
    var tasks: [Task] = []
    
    // instanciamos el dataBase
    private var taskDataBase = TaskDataBase()
    
    func create(task: String) {
        guard !task.isEmpty else {
            return
        }
        let newTask: Task = .init(text: task, isFavorite: false)
        // el presenter le informa al dataBase que hay una modificacion
        tasks = taskDataBase.create(task: newTask)
        // le avisamos a la vista atravez del delegado que el modelo se modifico
        delegate?.update()
    }
    func updateFavorite(taskId: UUID) {
        // el presenter le informa al dataBase que hay una modificacion
        tasks = taskDataBase.updateFavorite(taskId: taskId)
        // le avisamos a la vista atravez del delegado que el modelo se modifico
        delegate?.update()
    }
    func removeTasks(taskId: UUID){
        // el presenter le informa al dataBase que hay una modificacion
        tasks = taskDataBase.remove(taskId: taskId)
        // le avisamos a la vista atravez del delegado que el modelo se modifico
        delegate?.update()
    }
    @objc func removeAllTasks(){
        // el presenter le informa al dataBase que hay una modificacion
        tasks = taskDataBase.removeAll()
        // le avisamos a la vista atravez del delegado que el modelo se modifico
        delegate?.update()
    }
}


