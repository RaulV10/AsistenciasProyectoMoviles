//
//  Attendance.swift
//  Asistencias
//
//  Created by Raul Ernesto Villarreal Sigala on 3/31/19.
//  Copyright © 2019 Raul Ernesto Villarreal Sigala. All rights reserved.
//

class Attendance {
    var id: Int
    var groupStudentId: Int
    var attendanceTypeId: Int
    var date: String
    
    init(id: Int, groupStudentId: Int, attendanceTypeId: Int, date: String) {
        self.id = id
        self.groupStudentId = groupStudentId
        self.attendanceTypeId = attendanceTypeId
        self.date = date
    }
}
