//
//  StudentsVCTableEtx.swift
//  Asistencias
//
//  Created by Raul Ernesto Villarreal Sigala on 3/31/19.
//  Copyright © 2019 Raul Ernesto Villarreal Sigala. All rights reserved.
//

import UIKit
import SQLite

extension StudentsVC: UITableViewDelegate, UITableViewDataSource {
    
    func readValues() {
        studentList.removeAll()
        
        do {
            let query = studentsTable.select(studentsTable[*])
                .join(groupStudentTable, on: studentsTable[studentId] == groupStudentTable[groupStudentStudentId])
                .where(groupStudentGroupId == currentGroupId)
            let students = try globalDatabase.prepare(query)
            for student in students {
                studentList.append(Student(id: student[studentId], name: student[studentName], lastName: student[studentLastName], schoolId: student[studentSchoolId], image: student[studentImage] ?? ""))
            }
        } catch { print(error) }
        studentsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if studentList.count == 0 { studentsTableView.isHidden = true }
        else { studentsTableView.isHidden = false }
        return studentList.count
    }
    
    func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as StudentCell = cell else {
            return
        }
        
        cell.backgroundColor = .clear
        
        if cellHeights[indexPath.row] == Const.closeCellHeight {
            cell.unfold(false, animated: false, completion: nil)
        } else {
            cell.unfold(true, animated: false, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FoldingCell") as? StudentCell else { return UITableViewCell() }
        let student: Student
        student = studentList[indexPath.row]
        let initialFirstName = String((student.name).prefix(1))
        let initialLastName = String((student.lastName).prefix(1))
        cell.configureCell(initials: "\(initialFirstName)\(initialLastName)", name: student.name, lastName: student.lastName, studentId: student.schoolId)
        
        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
        cell.durationsForExpandedState = durations
        cell.durationsForCollapsedState = durations
        return cell
    }
    
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! StudentCell
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.row] == Const.closeCellHeight
        if cellIsCollapsed {
            cellHeights[indexPath.row] = Const.openCellHeight
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            cellHeights[indexPath.row] = Const.closeCellHeight
            cell.unfold(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
    }
    
}
