//
//  LunchViewModel.swift
//  BottleRocket
//
//  Created by Bryan Lee on 10/21/21.
//

import UIKit

class LunchViewModel {
    private var restaurants: [Restaurant] = [] {
        didSet {
            DispatchQueue.main.async {
                self.updateUI?()
            }
        }
    }
    private var networkService: NetworkServiceProcotol
    private var updateUI : (() -> Void)?
    
    init(networkService: NetworkServiceProcotol = NetworkService()) {
        self.networkService = networkService
        fetchRestaurants()
    }
    
    func bind(completion: @escaping () -> Void) {
        self.updateUI = completion
    }
    
    func fetchImage(imageStr: String, completion: @escaping (UIImage?) -> Void) {
        networkService.fetchImage(imageStr: imageStr, completion: completion)
    }
    
    func prefetchImage(imageStr: String) -> Void {
        networkService.fetchImage(imageStr: imageStr, completion: { _ in })
    }
    
    func numberOfRestaurants() -> Int {
        return restaurants.count
    }
    
    func imageStr(index: Int) -> String {
        return restaurants[index].backgroundImageURL ?? "Unknown"
    }
    
    func createLunchDetailVM(row: Int) -> LunchCellViewModel {
        LunchCellViewModel(restaurant: restaurants[row])
    }
    
    private func fetchRestaurants() {
        networkService.fetchRestaurants { result in
            switch result {
            case .success(let restaurants) :
                self.restaurants = restaurants
            case .failure(let error) :
                switch error {
                case RestaurantError.decodingError:
                    print("decoding error")
                case RestaurantError.noData:
                    print("no data")
                default:
                    print("default error")
                }
            }
        }
    }
}

