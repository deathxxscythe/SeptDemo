//
//  DrinksViewController.swift
//  week03assessment
//
//  Created by Nathaniel Patterson on 10/18/21.
//

import Foundation
import UIKit

class DrinksViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var coordinator: Coordinator!
    var data: [DrinksResponse] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(DrinksCell.nib(), forCellReuseIdentifier: "drinksCell")
        tableView.dataSource = self
    }
}

extension DrinksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let drinksCell = tableView.dequeueReusableCell(withIdentifier: DrinksCell.identifier, for: indexPath) as! DrinksCell
        
        return drinksCell
    }
    
    
}
