//
//  ViewController.swift
//  queryStrings
//
//  Created by Nathaniel Patterson on 10/28/21.
//

import UIKit

class ViewController: UIViewController {
    
    let choices = [
        "Ingredients",
        "Alcoholic",
        "Category",
        "Glass Type"
    ]
    
    @IBAction func searchButton(_ sender: Any) {
        let queryKey = getQueryKey()
        let quearyValue = searchBar.text?.replacingOccurrences(of: " ", with: "_")
        let a = Networking().createRequest(baseURL: "https://www.thecocktaildb.com/api/json/v1/1/filter.php", queryKey: queryKey, queryValue: quearyValue ?? "Gin")
        print(a)
        Networking().fetch(url: a){ [weak self ] response in
            self?.tableData = response.drinks
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    @IBOutlet weak var segmentedControll: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var tableData: [Drink]?
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        tableView.dataSource = self
        for (index, filterBy) in choices.enumerated() {
            segmentedControll.setTitle(filterBy, forSegmentAt: index)
        }
    }
    func getQueryKey() -> String {
        let queryKey: String
        switch segmentedControll.selectedSegmentIndex {
        case 0:
            queryKey = "i"
        case 1:
            queryKey = "a"
        case 2:
            queryKey = "c"
        default:
            queryKey = "g"
        }
        return queryKey
    }
}

