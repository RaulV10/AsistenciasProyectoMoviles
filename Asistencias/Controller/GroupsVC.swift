//
//  ViewController.swift
//  Asistencias
//
//  Created by Raul Ernesto Villarreal Sigala on 3/30/19.
//  Copyright © 2019 Raul Ernesto Villarreal Sigala. All rights reserved.
//

import UIKit
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
        let alert = UIAlertController(title: "Nuevo Grupo", message: nil, preferredStyle: .alert)
        alert.addTextField { (tf) in tf.placeholder = "Nombre" }
        alert.addTextField { (tf) in tf.placeholder = "Clave" }
        alert.addTextField { (tf) in tf.placeholder = "Limite de faltas" }
        
        let cancel = UIAlertAction(title: "Cancelar", style: .destructive, handler: nil)
        
        let insert = UIAlertAction(title: "Guardar", style: .default) { (_) in
            guard let name = alert.textFields?.first?.text,
                let code = alert.textFields?[1].text,
                let limit = alert.textFields?.last?.text
                else { return }
            
            let insertGroup = groupsTable.insert(groupName <- name, groupCode <- code, groupAbsenceLimit <- Int(limit) ?? 9)
            
            do { try globalDatabase.run(insertGroup) }
            catch { print(error) }
            
            Loaf("Grupo Creado", state: .success, sender: self).show()
            self.readValues()
        }
        alert.addAction(cancel)
        alert.addAction(insert)
        present(alert, animated: true, completion: nil)
        
    }
    
}

