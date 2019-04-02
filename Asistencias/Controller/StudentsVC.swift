//
//  StudentsVC.swift
//  Asistencias
//
//  Created by Raul Ernesto Villarreal Sigala on 3/31/19.
//  Copyright © 2019 Raul Ernesto Villarreal Sigala. All rights reserved.
//

import UIKit

class StudentsVC: UIViewController {

    @IBOutlet weak var studentsTableView: UITableView!
    
    var studentList = [Student]()
    
    enum Const {
        static let closeCellHeight: CGFloat = 179
        static let openCellHeight: CGFloat = 488
        static let rowsCount = 10
    }
    
    var cellHeights: [CGFloat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        studentsTableView.delegate = self
        studentsTableView.dataSource = self

        setup()
        readValues()
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    private func setup() {
        cellHeights = Array(repeating: Const.closeCellHeight, count: Const.rowsCount)
        studentsTableView.estimatedRowHeight = Const.closeCellHeight
        studentsTableView.rowHeight = UITableView.automaticDimension
        if #available(iOS 10.0, *) {
            studentsTableView.refreshControl = UIRefreshControl()
            studentsTableView.refreshControl?.addTarget(self, action: #selector(refreshHandler), for: .valueChanged)
        }
    }
    
    @objc func refreshHandler() {
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: { [weak self] in
            if #available(iOS 10.0, *) {
                self?.studentsTableView.refreshControl?.endRefreshing()
            }
            self?.studentsTableView.reloadData()
        })
        readValues()
    }
    
    @objc func loadList(notification: NSNotification){
        readValues()
    }

}
