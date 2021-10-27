//
//  JokesViewController.swift
//  week03assessment
//
//  Created by Nathaniel Patterson on 10/18/21.
//

import Foundation
import UIKit

class JokesViewController: UIViewController {
    
    @IBOutlet weak var setupLabel: UILabel!
    @IBOutlet weak var deliveryLabel: UILabel!
    var coordinator: Coordinator!
    override func viewDidLoad() {
        super.viewDidLoad()
        JokesViewModel.fetch() { [weak self] response in
            print(response)
            DispatchQueue.main.async {
                print("test",response)
                self?.setupLabel.text = response.setup
                self?.deliveryLabel.text = response.delivery
            }
        }
    }
}
