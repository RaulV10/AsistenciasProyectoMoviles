//
//  Attendance.swift
//  Asistencias
//
//  Created by Raul Ernesto Villarreal Sigala on 3/31/19.
//  Copyright © 2019 Raul Ernesto Villarreal Sigala. All rights reserved.
//

class Attendance {
    var name: String
    var lastName: String
    var schoolId: Int
    var groupStudentId: Int
    var attendanceTypeId: Int
    var date: String
    
    init(name: String, lastName: String, schoolId: Int, groupStudentId: Int, attendanceTypeId: Int, date: String) {
        self.name = name
        self.lastName = lastName
        self.schoolId = schoolId
        self.groupStudentId = groupStudentId
        self.attendanceTypeId = attendanceTypeId
        self.date = date
    }
}
