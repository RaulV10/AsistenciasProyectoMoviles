//
//  StudentCell.swift
//  Asistencias
//
//  Created by Raul Ernesto Villarreal Sigala on 3/31/19.
//  Copyright © 2019 Raul Ernesto Villarreal Sigala. All rights reserved.
//

import UIKit
import FoldingCell

class StudentCell: FoldingCell {
    
    @IBOutlet weak var initialsView: UIView!
    
    @IBOutlet weak var lblInitialsFolded: UILabel!
    @IBOutlet weak var lblFullNameFolded: UILabel!
    @IBOutlet weak var lblStudentIdFolded: UILabel!
    
    @IBOutlet weak var lblStudentIdMenu: UILabel!
    
    @IBOutlet weak var lblInitialsUnfolded: UILabel!
    @IBOutlet weak var lblFullNameUnfolded: UILabel!
    @IBOutlet weak var lblStudentIdUnfolded: UILabel!
    
    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type _: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
    
    func configureCell(initials: String, name: String, lastName: String, studentId: Int) {
        self.lblInitialsFolded.text = initials
        self.lblFullNameFolded.text = "\(name) \(lastName)"
        self.lblStudentIdFolded.text = "Matricula: \(String(studentId))"
        
        self.lblStudentIdMenu.text = "\(String(studentId))"
        
        self.lblInitialsUnfolded.text = initials
        self.lblFullNameUnfolded.text = "\(name) \(lastName)"
        self.lblStudentIdUnfolded.text = "Matricula: \(String(studentId))"
    }
    
}
