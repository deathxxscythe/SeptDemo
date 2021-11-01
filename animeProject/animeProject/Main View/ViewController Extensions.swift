//
//  ViewController Extensions.swift
//  animeProject
//
//  Created by Nathaniel Patterson on 10/31/21.
//

import Foundation
import UIKit

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.searchType == "anime" {
            viewModel.setUrl(url: viewModel.showData![indexPath.row].url!)
        } else {
            viewModel.setUrl(url: viewModel.characterData![indexPath.row].url!)
        }
        delegate.pushWebKit(url: viewModel.getUrl())
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.searchType == "anime" {
            return viewModel.showData!.count
        } else if viewModel.searchType == "character" {
            return viewModel.characterData!.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.searchType == "anime" {
            let showCell = tableView.dequeueReusableCell(withIdentifier: "ShowCell", for: indexPath) as! ShowsCell
            let cellData = viewModel.showData![indexPath.row]
            showCell.configure(title: cellData.title, episodes: cellData.episodes, description: cellData.synopsis ?? "")
            if let cachedImage = ImageCache.shared.read(imageStr: cellData.image_url) {
                showCell.showImage.image = cachedImage
            } else {
                let currentRunningTask = ImageCache.shared.startFetchRequest(imageStr: cellData.image_url) { image in
                    DispatchQueue.main.async {
                        showCell.showImage.image = image
                    }
                }
                showCell.onReuse = {
                    if let currentRunningTask = currentRunningTask {
                        ImageCache.shared.runningTasks[currentRunningTask]?.cancel()
                        ImageCache.shared.runningTasks.removeValue(forKey: currentRunningTask)
                    }

                }
            }
            
            return showCell
        } else {
            let characterCell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as! CharactersCell
            let cellData = viewModel.characterData![indexPath.row]
            characterCell.configure(charName: cellData.name)
            if let cachedImage = ImageCache.shared.read(imageStr: cellData.image_url) {
                characterCell.characterImage.image = cachedImage
            } else {
                let currentRunningTask = ImageCache.shared.startFetchRequest(imageStr: cellData.image_url) { image in
                    DispatchQueue.main.async {
                        characterCell.characterImage.image = image
                    }
                }
                characterCell.onReuse = {
                    if let currentRunningTask = currentRunningTask {
                        ImageCache.shared.runningTasks[currentRunningTask]?.cancel()
                        ImageCache.shared.runningTasks.removeValue(forKey: currentRunningTask)
                    }

                }
            }

            return characterCell
        }
        
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.searchType = getQueryKey()
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

