//
//  Grupos.swift
//  Asistencias
//
//  Created by Raul Ernesto Villarreal Sigala on 3/31/19.
//  Copyright © 2019 Raul Ernesto Villarreal Sigala. All rights reserved.
//

import UIKit
import SQLite

extension GroupsVC {
    let id = Expression<Int>("id")
    let nombreGrupo = Expression<String>("nombreGrupo")
}
