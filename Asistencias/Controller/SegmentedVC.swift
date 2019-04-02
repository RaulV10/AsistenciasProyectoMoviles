//
//  SegmentedVC.swift
//  Asistencias
//
//  Created by Raul Ernesto Villarreal Sigala on 3/31/19.
//  Copyright © 2019 Raul Ernesto Villarreal Sigala. All rights reserved.
//

import UIKit
import SQLite
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
        let alert = UIAlertController(title: "Nuevo Alumno", message: nil, preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = "Nombre(s)" }
        alert.addTextField { (tf) in tf.placeholder = "Apellido(s)" }
        alert.addTextField { (tf) in tf.keyboardType = .numberPad; tf.placeholder = "Matricula" }
        
        let cancel = UIAlertAction(title: "Cancelar", style: .destructive, handler: nil)
        
        let insert = UIAlertAction(title: "Guardar", style: .default) { (_) in
            guard let name = alert.textFields?.first?.text,
                let lastName = alert.textFields?[1].text,
                let studentId = alert.textFields?.last?.text
                else { return }
            
        let insertStudent = studentsTable.insert(studentName <- name, studentLastName <- lastName, studentSchoolId <- Int(studentId)!)
        
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
        alert.addAction(cancel)
        alert.addAction(insert)
        present(alert, animated: true, completion: nil)
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
