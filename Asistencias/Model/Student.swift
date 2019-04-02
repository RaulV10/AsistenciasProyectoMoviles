//
//  Student.swift
//  Asistencias
//
//  Created by Raul Ernesto Villarreal Sigala on 3/31/19.
//  Copyright © 2019 Raul Ernesto Villarreal Sigala. All rights reserved.
//

class Student {
    var id: Int
    var name: String
    var lastName: String
    var schoolId: Int
    var image: String
    
    init(id: Int, name: String, lastName: String, schoolId: Int, image: String) {
        self.id = id
        self.name = name
        self.lastName = lastName
        self.schoolId = schoolId
        self.image = image
    }
}
