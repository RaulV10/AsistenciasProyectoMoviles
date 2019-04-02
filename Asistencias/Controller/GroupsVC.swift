//
//  ViewController.swift
//  Asistencias
//
//  Created by Raul Ernesto Villarreal Sigala on 3/30/19.
//  Copyright © 2019 Raul Ernesto Villarreal Sigala. All rights reserved.
//

import UIKit
import SCLAlertView
import SQLite
import Loaf

class GroupsVC: UIViewController {

    @IBOutlet var groupsTableView: UITableView!
    
    var groupList = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupsTableView.delegate = self
        groupsTableView.dataSource = self
        groupsTableView.isHidden = false
        
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("attendance").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            globalDatabase = database
        } catch { print(error) }
        
        createGroupsTable()
        createStudentsTable()
        createGroupStudentTable()
        createAttendanceTypeTable()
        createAttendanceTable()
        
        readValues()
        
        print(globalDatabase)
    }

    @IBAction func addGroup(_ sender: Any) {
        let appearance = SCLAlertView.SCLAppearance(
            kTextFieldHeight: 60,
            showCloseButton: true
        )
        
        let alert = SCLAlertView(appearance: appearance)
        let name = alert.addTextField("Nombre")
        let code = alert.addTextField("Clave")
        let limit = alert.addTextField("Limite de faltas")
        _ = alert.addButton("Guardar") {
            let insertGroup = groupsTable.insert(groupName <- name.text ?? "", groupCode <- code.text ?? "", groupAbsenceLimit <- Int(limit.text ?? "9") ?? 9)
            
            do { try globalDatabase.run(insertGroup) }
            catch { print(error) }
            
            Loaf("Grupo Creado", state: .success, sender: self).show()
            self.readValues()
        }
        _ = alert.showEdit("Nuevo Grupo", subTitle:"Crea un nuevo grupo")
        
    }
    
}

