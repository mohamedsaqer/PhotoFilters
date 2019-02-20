//
//  TableViewController.swift
//  Saqer Filters
//
//  Created by Mohamed Saqer on 2/20/19.
//  Copyright © 2019 Mohamed Saqer. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let filters = ["Red", "Blue", "Green", "Yellow"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath)
        
        cell.textLabel?.text = filters[indexPath.row]
        return cell
    }

}
