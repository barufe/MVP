//
//  Task.swift
//  ListOfTask
//
//  Created by Germain Seijas on 29/01/24.
//

import Foundation

struct Task {
    let id: UUID = UUID()
    let text: String
    var isFavorite: Bool
}
