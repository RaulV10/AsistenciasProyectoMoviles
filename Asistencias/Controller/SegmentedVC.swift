//
//  SegmentedVC.swift
//  Asistencias
//
//  Created by Raul Ernesto Villarreal Sigala on 3/31/19.
//  Copyright © 2019 Raul Ernesto Villarreal Sigala. All rights reserved.
//

import UIKit
import SQLite
import SCLAlertView
import Loaf

class SegmentedVC: UIViewController {

    @IBOutlet weak var viewAttendance: UIView!
    @IBOutlet weak var viewStudents: UIView!
    
    let studentVC = StudentsVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(currentGroupId)
    }
    
    func initStudents(group: Group) {
        navigationItem.title = group.name
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        currentGroupId = group.id
    }
    
    func returnGroupId() -> Int {
        return currentGroupId
    }
    
    @objc func addTapped() {
        let appearance = SCLAlertView.SCLAppearance(
            kTextFieldHeight: 60,
            showCloseButton: true
        )
        
        let alert = SCLAlertView(appearance: appearance)
        let name = alert.addTextField("Nombre(s)")
        let lastname = alert.addTextField("Apellido(s)")
        let schoolId = alert.addTextField("Matricula")
        _ = alert.addButton("Guardar") {
            let insertStudent = studentsTable.insert(studentName <- name.text ?? "", studentLastName <- lastname.text ?? "", studentSchoolId <- Int(schoolId.text ?? "000000")!)
            
            do {
                try globalDatabase.run(insertStudent)
                let lastId = globalDatabase.lastInsertRowid
                
                let insertGroupStudent = groupStudentTable.insert(groupStudentGroupId <- currentGroupId, groupStudentStudentId <- Int(lastId))
                
                do { try globalDatabase.run(insertGroupStudent) }
                catch { print(error) }
            }
            catch { print(error) }
            
            Loaf("Alumno Agregado", state: .success, sender: self).show()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }
        _ = alert.showEdit("Nuevo Grupo", subTitle:"Crea un nuevo grupo")
        
    }
    
    @IBAction func segmAttendanceStudents(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            viewAttendance.alpha = 1
            viewStudents.alpha = 0
        case 1:
            viewStudents.alpha = 1
            viewAttendance.alpha = 0
        default:
            viewAttendance.alpha = 1
            viewStudents.alpha = 0
        }
    }
    
}
