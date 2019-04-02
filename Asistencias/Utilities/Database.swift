//
//  Grupos.swift
//  Asistencias
//
//  Created by Raul Ernesto Villarreal Sigala on 3/31/19.
//  Copyright © 2019 Raul Ernesto Villarreal Sigala. All rights reserved.
//

import Foundation
import SQLite

// Database Connection variable
var globalDatabase: Connection!

//
var currentGroupId = 0

// GROUPS TABLE
let groupsTable = Table("groups")
let groupId = Expression<Int>("id")
let groupName = Expression<String>("name")
let groupCode = Expression<String>("code")
let groupAbsenceLimit = Expression<Int>("absenceLimit")

// STUDENTS TABLE
let studentsTable = Table("students")
let studentId = Expression<Int>("id")
let studentName = Expression<String>("name")
let studentLastName = Expression<String>("lastName")
let studentSchoolId = Expression<Int>("studentId")
let studentImage = Expression<String?>("image")

// GROUP_STUDENT TABLE
let groupStudentTable = Table("group_student")
let groupStudentId = Expression<Int>("id")
let groupStudentGroupId = Expression<Int>("groupId")
let groupStudentStudentId = Expression<Int>("studentId")

// ATTENDANCE_TYPE TABLE
let attendanceTypeTable = Table("attendance_type")
let attendanceTypeId = Expression<Int>("id")
let attendanceTypeName = Expression<String>("name")

// ATTENDANCE TABLE
let attendanceTable = Table("attendance")
let attendanceId = Expression<Int>("id")
let attendanceGroupStudentId = Expression<Int>("groupStudentId")
let attendanceAttendanceTypeId = Expression<Int>("attendanceTypeId")
let attendanceDate = Expression<String>("date")
