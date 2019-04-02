//
//  GroupsVCTableExt.swift
//  Asistencias
//
//  Created by Raul Ernesto Villarreal Sigala on 3/31/19.
//  Copyright © 2019 Raul Ernesto Villarreal Sigala. All rights reserved.
//

import UIKit

extension GroupsVC: UITableViewDelegate, UITableViewDataSource {
    
    func readValues() {
        groupList.removeAll()
        
        do {
            let groups = try globalDatabase.prepare(groupsTable)
            for group in groups {
                groupList.append(Group(id: group[groupId], name: group[groupName], code: group[groupCode], limit: group[groupAbsenceLimit]))
            }
        }
        catch { print(error) }
        groupsTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if groupList.count == 0 { groupsTableView.isHidden = true }
        else { groupsTableView.isHidden = false }
        return groupList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell") as? GroupCell else { return UITableViewCell() }
        let group: Group
        group = groupList[indexPath.row]
        cell.configureCell(name: group.name, code: group.code)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let group: Group
        group = groupList[indexPath.row]
        performSegue(withIdentifier: "AttendanceVC", sender: group)
        tableView.deselectRow(at: indexPath, animated: true)
//        print(indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segmentedVC = segue.destination as? SegmentedVC {
//            let btnBack = UIBarButtonItem()
//            btnBack.title = ""
//            navigationItem.backBarButtonItem = btnBack
//
//            assert(sender as? Group != nil)
//            attendanceVC.initStudents(group: sender as! Group)
            segmentedVC.initStudents(group: sender as! Group)
        }
    }
    
}
