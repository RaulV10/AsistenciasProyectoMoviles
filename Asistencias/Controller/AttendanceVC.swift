//
//  AttendanceVC.swift
//  Asistencias
//
//  Created by Raul Ernesto Villarreal Sigala on 3/31/19.
//  Copyright © 2019 Raul Ernesto Villarreal Sigala. All rights reserved.
//

import UIKit
import Loaf

class AttendanceVC: UIViewController {

    @IBOutlet weak var txtDatePicker: UITextField!
    @IBOutlet weak var attendanceTableView: UITableView!
    
    let datePicker = UIDatePicker()
    let date = Date()
    let formatter = DateFormatter()
    
    var fecha: String = ""
    var attendanceList = [Student]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attendanceTableView.delegate = self
        attendanceTableView.dataSource = self
        
        readValues()
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        
        fillAttendanceTypeTable()
        
        formatter.dateFormat = "dd/MM/yyyy"
        let todayDate = formatter.string(from: date)
        txtDatePicker.text = todayDate
        showDatePicker()
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
        
        print(fecha)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    @objc func loadList(notification: NSNotification){
        readValues()
    }
}

