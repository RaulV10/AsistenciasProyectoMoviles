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
//                attendanceList.append(Student(id: student[studentId], name: student[studentName], lastName: student[studentLastName], schoolId: student[studentSchoolId], image: student[studentImage] ?? ""))
                attendanceList.append(Attendance(name: student[studentName], lastName: student[studentLastName], schoolId: student[studentSchoolId], groupStudentId: student[groupStudentId], attendanceTypeId: state, date: todayDate))
            }
        } catch { print(error) }
        attendanceTableView.reloadData()
    }
    
    func newSelectInNewDate() {
        attendanceList.removeAll()
        
        do {
            let query = groupStudentTable.select(groupStudentTable[groupStudentId], attendanceTable[attendanceDate], attendanceTable[attendanceAttendanceTypeId], studentsTable[studentName], studentsTable[studentLastName], studentsTable[studentSchoolId])
                .join(studentsTable, on: groupStudentTable[groupStudentStudentId] == studentsTable[studentId])
                .join(groupsTable, on: groupStudentTable[groupStudentGroupId] == groupsTable[groupId])
                .join(attendanceTable, on: groupStudentTable[groupStudentId] == attendanceTable[attendanceGroupStudentId])
                .filter(attendanceTable[attendanceDate].like(todayDate))
            let students = try globalDatabase.prepare(query)
            for student in students {
                attendanceList.append(Attendance(name: student[studentName], lastName: student[studentLastName], schoolId: student[studentSchoolId], groupStudentId: student[groupStudentId], attendanceTypeId: student[attendanceAttendanceTypeId], date: todayDate))
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
        let student: Attendance
        student = attendanceList[indexPath.row]
        let initialFirstName = String((student.name).prefix(1))
        let initialLastName = String((student.lastName).prefix(1))
        cell.configureCell(initials: "\(initialFirstName)\(initialLastName)", name: student.name, lastName: student.lastName, studentId: student.schoolId)
        
        switch attendanceList[indexPath.row].attendanceTypeId {
        case AttendanceType.present.rawValue:
            cell.viewBackgroundColor.backgroundColor = #colorLiteral(red: 0.5607843137, green: 0.8745098039, blue: 0.2941176471, alpha: 1)
        case AttendanceType.absent.rawValue:
            cell.viewBackgroundColor.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.3215686275, blue: 0.3058823529, alpha: 1)
        case AttendanceType.late.rawValue:
            cell.viewBackgroundColor.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.9058823529, blue: 0.3725490196, alpha: 1)
        case AttendanceType.justify.rawValue:
            cell.viewBackgroundColor.backgroundColor = #colorLiteral(red: 0.4549019608, green: 0.7843137255, blue: 0.8784313725, alpha: 1)
        default:
            cell.viewBackgroundColor.backgroundColor = #colorLiteral(red: 0.5607843137, green: 0.8745098039, blue: 0.2941176471, alpha: 1)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(attendanceList[indexPath.row].schoolId)
        (attendanceList[indexPath.row].attendanceTypeId >= 4) ? (attendanceList[indexPath.row].attendanceTypeId = 1) : (attendanceList[indexPath.row].attendanceTypeId += 1)
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
