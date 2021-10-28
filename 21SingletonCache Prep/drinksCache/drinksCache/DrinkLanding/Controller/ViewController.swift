//
//  ViewController.swift
//  drinksCache
//
//  Created by Luat on 8/23/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let drinkAddress = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=Gin"
    
    var drinks: [DrinkItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        fetchData()
        
    }
    
    func fetchData() {
        downloadData { model in
            self.drinks = model.drinks
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: DrinkCell.identifier, bundle: nil), forCellReuseIdentifier: DrinkCell.identifier)
    }
    
    func downloadData(completion: @escaping (DrinkModel) -> Void) {
        print("calling API")
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
        cell.drinkName.text = "\(indexPath.row): " + drinkItem.name
        cell.drinkDesc.text = drinkItem.idDrink
        
        
        /// Downloads image
        fetchImage(imageStr: drinkItem.imageStr) { image in
            cell.drinkImageView.image = image
        }
        
        return cell
    }
    
    func fetchImage(imageStr: String, completion: @escaping (UIImage?) -> Void) {
        completion(nil)
        if let image = ImageCache.shared.read(imageStr: imageStr) {
            completion(image)
        } else {
            guard let url = URL(string: imageStr) else { fatalError() }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    if let data = data, let image = UIImage(data: data) {
                        ImageCache.shared.write(imageStr: imageStr, image: image)
                        completion(image)
                    }
                }
            }.resume()
        }
    }
}

extension ViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            let drinkItem = drinks[indexPath.row]
            fetchImage(imageStr: drinkItem.imageStr, completion: { _ in })
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("indexpath: \(indexPath)")
        guard let detailsVC = storyboard?.instantiateViewController(identifier: "DetailsVC") as? DrinkDetailsViewController else { return }
        
        detailsVC.drinkItem = drinks[indexPath.row]
        
        navigationController?.pushViewController(detailsVC, animated: true)
        
    }
}
