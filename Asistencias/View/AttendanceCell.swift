//
//  AttendanceCell.swift
//  Asistencias
//
//  Created by Raul Ernesto Villarreal Sigala on 3/31/19.
//  Copyright © 2019 Raul Ernesto Villarreal Sigala. All rights reserved.
//

import UIKit

class AttendanceCell: UITableViewCell {

    @IBOutlet weak var lblInitials: UILabel!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var lblStudentId: UILabel!
    @IBOutlet weak var viewBackgroundColor: UIView!
    
    var state: Int = 1
    
    func configureCell(initials: String, name: String, lastName: String, studentId: Int) {
        self.lblInitials.text = initials
        self.lblFullName.text = "\(name) \(lastName)"
        self.lblStudentId.text = "Matricula: \(String(studentId))"
    }
    
    override func awakeFromNib() {
        viewBackgroundColor.layer.cornerRadius = 10
        viewBackgroundColor.layer.masksToBounds = true
        viewBackgroundColor.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        super.awakeFromNib()
    }
    
}
