//
//  ViewController.swift
//  drinksCache
//
//  Created by Luat on 8/23/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let drinkAddress = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=cocktail"
    
    var drinks: [DrinkItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        fetchData()
        
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: DrinkCell.identifier, bundle: nil), forCellReuseIdentifier: DrinkCell.identifier)
    }
    
    func fetchData() {
        downloadData { model in
            self.drinks = model.drinks
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func downloadData(completion: @escaping (DrinkModel) -> Void) {
        print("download data func start")
        guard let url = URL(string: drinkAddress) else { return }
        URLSession.shared.dataTask(with: url) { (data,_,_) in
            guard let data = data else { return }
            if let decoded = try? JSONDecoder().decode(DrinkModel.self, from: data) {
                completion(decoded)
                print("completion is called")
            }
        }.resume()
        print("download data func ends")
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        drinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DrinkCell.identifier) as? DrinkCell else { fatalError() }
        
        let drinkItem = drinks[indexPath.row]
        cell.drinkName.text = drinkItem.name
        cell.drinkDesc.text = drinkItem.idDrink

        
        /// Check if cache has image, load from cache
        if let cachedImage = ImageCache.shared.read(imageStr: drinkItem.imageStr) {
            cell.drinkImageView.image = cachedImage
            
        /// If not, fetch image from API
        } else {
            /// 4. Start task for each cell
            /// - Prepare to cancel this task, IF cell is being reused && task exist in runningTask
            let runningImageStr = ImageCache.shared.startFetchRequest(imageStr: drinkItem.imageStr) { image in
                DispatchQueue.main.async {
                    cell.drinkImageView.image = image
                }
            }
            /// 5. IF cell is reused: prepareForReuse() called - cancel any tasks associated with the cell
            cell.onReuse = {
                if let runningImageStr = runningImageStr {
                    ImageCache.shared.runningTasks[runningImageStr]?.cancel()
                    ImageCache.shared.runningTasks.removeValue(forKey: runningImageStr)
                }
            }
        }
        
        return cell
    }
    
    

}
