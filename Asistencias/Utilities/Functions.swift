//
//  Functions.swift
//  Asistencias
//
//  Created by Raul Ernesto Villarreal Sigala on 3/31/19.
//  Copyright © 2019 Raul Ernesto Villarreal Sigala. All rights reserved.
//

import Foundation
import SQLite

/*********************************** CREATE ***********************************/
func createGroupsTable() {
    let createTable = groupsTable.create(ifNotExists: true) { (table) in
        table.column(groupId, primaryKey: true)
        table.column(groupName)
        table.column(groupCode)
        table.column(groupAbsenceLimit)
    }
    
    do { try globalDatabase.run(createTable) }
    catch { print(error) }
}

func createStudentsTable() {
    let createTable = studentsTable.create(ifNotExists: true) { (table) in
        table.column(studentId, primaryKey: true)
        table.column(studentName)
        table.column(studentLastName)
        table.column(studentSchoolId, unique: true)
        table.column(studentImage)
    }
    
    do { try globalDatabase.run(createTable) }
    catch { print(error) }
}

func createGroupStudentTable() {
    let createTable = groupStudentTable.create(ifNotExists: true) { (table) in
        table.column(groupStudentId, primaryKey: true)
        table.column(groupStudentGroupId, references: groupsTable, groupId)
        table.column(groupStudentStudentId, references: studentsTable, studentId)
    }
    
    do { try globalDatabase.run(createTable) }
    catch { print(error) }
}

func createAttendanceTypeTable() {
    let createTable = attendanceTypeTable.create(ifNotExists: true) { (table) in
        table.column(attendanceTypeId, primaryKey: true)
        table.column(attendanceTypeName)
    }
    
    do { try globalDatabase.run(createTable) }
    catch { print(error) }
}

func createAttendanceTable() {
    let createTable = attendanceTable.create(ifNotExists: true) { (table) in
        table.column(attendanceId, primaryKey: true)
        table.column(attendanceGroupStudentId, references: groupStudentTable, groupStudentId)
        table.column(attendanceAttendanceTypeId, references: attendanceTypeTable, attendanceTypeId)
        table.column(attendanceDate)
    }
    
    do { try globalDatabase.run(createTable) }
    catch { print(error) }
}

/******************************************************************************/

/************************************ READ ************************************/
//func readGroupsTable() -> AnySequence<Row> {
//    var groupsSelected: AnySequence<Row>
//    
//    
//    return groupsSelected
//}

/******************************************************************************/

func fillAttendanceTypeTable() {
    let insertPresent = attendanceTypeTable.insert(attendanceTypeId <- AttendanceType.present.rawValue, attendanceTypeName <- "Asistencia")
    do { try globalDatabase.run(insertPresent) }
    catch { print(error) }
    
    let insertAbsent = attendanceTypeTable.insert(attendanceTypeId <- AttendanceType.absent.rawValue, attendanceTypeName <- "Falta")
    do { try globalDatabase.run(insertAbsent) }
    catch { print(error) }
    
    let insertLate = attendanceTypeTable.insert(attendanceTypeId <- AttendanceType.late.rawValue, attendanceTypeName <- "Retardo")
    do { try globalDatabase.run(insertLate) }
    catch { print(error) }
    
    let insertJustify = attendanceTypeTable.insert(attendanceTypeId <- AttendanceType.justify.rawValue, attendanceTypeName <- "Justificado")
    do { try globalDatabase.run(insertJustify) }
    catch { print(error) }
}
