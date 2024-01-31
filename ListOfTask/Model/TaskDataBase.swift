//
//  TaskDataBase.swift
//  ListOfTask
//
//  Created by Germain Seijas on 29/01/24.
//


// Hacemos toda la logica de negocio, desde la funcion para llamar servicios de la api, hasta el de modificar el modelo. (el presenter se conecta con el )

import Foundation

final class TaskDataBase {
    var tasks: [Task]
    // se inicializa el modelo en vacio
    init(tasks: [Task] = []) {
        self.tasks = tasks
    }
    
    func create(task: Task) -> [Task] {
        //Se modifica el modelo
        tasks.append(task)
        //Se devuelve el resultado al presenter
        return tasks
    }
    
    func updateFavorite(taskId: UUID) -> [Task]{
        //Se modifica el modelo
        if let index = tasks.firstIndex(where: {$0.id == taskId}){
            tasks[index].isFavorite = !tasks[index].isFavorite
        }
        //Se devuelve el resultado al presenter
        return tasks
    }
    
    func remove(taskId: UUID) -> [Task]{
        //Se modifica el modelo
        if let index = tasks.firstIndex(where: {$0.id == taskId}){
            tasks.remove(at: index)
        }
        //Se devuelve el resultado al presenter
        return tasks
    }
    
    func removeAll() -> [Task]{
        //Se modifica el modelo
        tasks.removeAll()
        //Se devuelve el resultado al presenter
        return tasks
    }
}
