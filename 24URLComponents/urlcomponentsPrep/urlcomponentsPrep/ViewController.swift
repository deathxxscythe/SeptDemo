//
//  ViewController.swift
//  urlcomponentsPrep
//
//  Created by Luat on 10/28/21.
//

import UIKit

class ViewController: UIViewController {

    let baseAddress = "https://www.thecocktaildb.com/api/json/v1/1/filter.php"
    let ginAddress = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=gin"
    /// Search by ingredients: "?i=gin"
    /// Gin, Rum, Vodka, Tequila, Scotch, Ale
    
    /*
    Filter by alcoholic
    www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic
    www.thecocktaildb.com/api/json/v1/1/filter.php?a=Non_Alcoholic
    
    Filter by Category
    www.thecocktaildb.com/api/json/v1/1/filter.php?c=Ordinary_Drink
    www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail
    
    Filter by Glass
    www.thecocktaildb.com/api/json/v1/1/filter.php?g=Cocktail_glass
    www.thecocktaildb.com/api/json/v1/1/filter.php?g=Champagne_flute
    */
    
    let filterStr = [
        "Ingredients",
        "Alcoholic",
        "Category",
        "Glass Type"
    ]
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var segmentedControll: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func searchPressed(_ sender: Any) {
        let pickerIndex = pickerView.selectedRow(inComponent: 0)
        print("Picker selection: ", filterStr[pickerIndex])
        
        let segmentedIndex = segmentedControll.selectedSegmentIndex
        print("Segmented Control selection: ", filterStr[segmentedIndex])
        fetch()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePickerView()
        configureSegmentedToggle()
        
    }
    
    func configurePickerView() {
        pickerView.dataSource = self
        pickerView.delegate = self
    }

    func configureSegmentedToggle() {
        for (index, filterBy) in filterStr.enumerated() {
            segmentedControll.setTitle(filterBy, forSegmentAt: index)
        }
    }
    
    func createRequest() -> URLRequest {
        guard let url = URL(string: ginAddress) else {
            fatalError("url is required")
        }

        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        let queryKey = getQueryKey()
        let queryItems = URLQueryItem(name: queryKey, value: searchBar.text)
        
        components?.queryItems = [queryItems]

        guard let finalURl = components?.url else  {
            fatalError("URL optional is nil")
        }
        let request = URLRequest(url: finalURl)
        
        return request
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
    
    func fetch() {
        var request = createRequest()
        
/// can do "POST", "DELETE", etc.
        request.httpMethod = "GET"
        
/// Need a body for "POST"
//        request.httpBody = Data()
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, resp, error in
            print("request url: ", request.url!)
        }
        dataTask.resume()
    }

}

