//
//  DataModel.swift
//  Quiz Game
//
//  Created by Pro on 03.08.2023.
//

struct DataModel: Codable, Identifiable {
    var id: Int
    var answer: String
    var question: String
}



