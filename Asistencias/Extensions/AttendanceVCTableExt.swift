//
//  AttendanceVCTableExt.swift
//  Asistencias
//
//  Created by Raul Ernesto Villarreal Sigala on 3/31/19.
//  Copyright © 2019 Raul Ernesto Villarreal Sigala. All rights reserved.
//

import UIKit
import SQLite

extension AttendanceVC: UITableViewDelegate, UITableViewDataSource {
    
    func readValues() {
        attendanceList.removeAll()
        
        do {
            let query = studentsTable.select(studentsTable[*])
                .join(groupStudentTable, on: studentsTable[studentId] == groupStudentTable[groupStudentStudentId])
                .where(groupStudentGroupId == currentGroupId)
            let students = try globalDatabase.prepare(query)
            for student in students {
                attendanceList.append(Student(id: student[studentId], name: student[studentName], lastName: student[studentLastName], schoolId: student[studentSchoolId], image: student[studentImage] ?? ""))
            }
        } catch { print(error) }
        attendanceTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if attendanceList.count == 0 { attendanceTableView.isHidden = true }
        else { attendanceTableView.isHidden = false }
        return attendanceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "attendanceCell") as? AttendanceCell else { return UITableViewCell() }
        let student: Student
        student = attendanceList[indexPath.row]
        let initialFirstName = String((student.name).prefix(1))
        let initialLastName = String((student.lastName).prefix(1))
        cell.configureCell(initials: "\(initialFirstName)\(initialLastName)", name: student.name, lastName: student.lastName, studentId: student.schoolId)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(attendanceList[indexPath.row].schoolId)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
