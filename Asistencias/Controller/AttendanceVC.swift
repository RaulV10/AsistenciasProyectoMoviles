//
//  AttendanceVC.swift
//  Asistencias
//
//  Created by Raul Ernesto Villarreal Sigala on 3/31/19.
//  Copyright © 2019 Raul Ernesto Villarreal Sigala. All rights reserved.
//

import UIKit
import Loaf
import SQLite

class AttendanceVC: UIViewController {

    @IBOutlet weak var txtDatePicker: UITextField!
    @IBOutlet weak var attendanceTableView: UITableView!
    
    let datePicker = UIDatePicker()
    let date = Date()
    let formatter = DateFormatter()
    
    var fecha: String = ""
    var state = 1;
    var attendanceList = [Attendance]()
    
    var todayDate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attendanceTableView.delegate = self
        attendanceTableView.dataSource = self
        
        formatter.dateFormat = "dd/MM/yyyy"
        todayDate = formatter.string(from: date)
        txtDatePicker.text = todayDate
        showDatePicker()
        
        readValues()
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        
        fillAttendanceTypeTable()
    }
    
    func showDatePicker() {
        //Formate Date
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        txtDatePicker.inputAccessoryView = toolbar
        txtDatePicker.inputView = datePicker
    }
    
    @objc func donedatePicker(){
        formatter.dateFormat = "dd/MM/yyyy"
        txtDatePicker.text = formatter.string(from: datePicker.date)
        fecha = String(formatter.string(from: datePicker.date))
        self.view.endEditing(true)
        todayDate = fecha
        
        newSelectInNewDate()
        print(fecha)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    @objc func loadList(notification: NSNotification){
        readValues()
    }
    
    @IBAction func btnSaveAttendance(_ sender: Any) {
        for element in attendanceList {
//            print("\(element.schoolId) \(element.attendanceTypeId)")
            let insertAttendance = attendanceTable.insert(attendanceGroupStudentId <- element.groupStudentId, attendanceAttendanceTypeId <- element.attendanceTypeId, attendanceDate <- todayDate)
            
            do { try globalDatabase.run(insertAttendance) }
            catch { print(error) }
        }
    }
    
}

