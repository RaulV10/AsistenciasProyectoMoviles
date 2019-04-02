//
//  GroupCell.swift
//  Asistencias
//
//  Created by Raul Ernesto Villarreal Sigala on 3/31/19.
//  Copyright © 2019 Raul Ernesto Villarreal Sigala. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet weak var lblGroupName: UILabel!
    @IBOutlet weak var lblGroupCode: UILabel!
    
    func configureCell(name: String, code: String) {
        self.lblGroupName.text = name
        self.lblGroupCode.text = "Clave: \(code)"
    }
    
}
