//
//  ViewController.swift
//  animeProject
//
//  Created by Nathaniel Patterson on 10/30/21.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func segmentedControllerAction(_ sender: Any) {
        self.viewModel.searchType = getQueryKey()
        networkRequest()
    }
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var delegate: Coordinator!
    var viewModel: MainViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        tableView.register(UINib(nibName: "ShowsCell", bundle: nil), forCellReuseIdentifier: "ShowCell")
        tableView.register(UINib(nibName: "CharactersCell", bundle: nil), forCellReuseIdentifier: "CharacterCell")
        
        setupViewModel()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    func setupViewModel() {
        self.viewModel = MainViewModel()
        
        let updateShowData: ([Show]) -> Void = { [weak self] postData in
            self?.tableView.reloadData()
        }
        
        let updateCharacterData: ([Character]) -> Void = { [weak self] postData in
            self?.tableView.reloadData()
        }
        
        viewModel?.updateShowData = updateShowData
        viewModel?.updateCharacterData = updateCharacterData
    }
    func getQueryKey() -> String {
        let queryKey: String
        switch segmentedController.selectedSegmentIndex {
        case 0:
            queryKey = "anime"
        default:
            queryKey = "character"
        }
        return queryKey
    }
    func networkRequest() {
        let search: String = searchBar.text!.replacingOccurrences(of: " ", with: "_")
        
        if viewModel.searchType == "anime" {
            Networking().fetchShows(search: search){ data in
                DispatchQueue.main.async {
                    self.viewModel.showData = data
                }
            }
        } else {
            Networking().fetchCharacters(search: search) { data in
                DispatchQueue.main.async {
                    self.viewModel.characterData = data
                }
            }
        }
    }
}
