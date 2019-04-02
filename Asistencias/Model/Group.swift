//
//  Group.swift
//  Asistencias
//
//  Created by Raul Ernesto Villarreal Sigala on 3/31/19.
//  Copyright © 2019 Raul Ernesto Villarreal Sigala. All rights reserved.
//

class Group {
    var id: Int
    var name: String
    var code: String
    var limit: Int
    
    init(id: Int, name: String, code: String, limit: Int){
        self.id = id
        self.name = name
        self.code = code
        self.limit = limit
    }
}
