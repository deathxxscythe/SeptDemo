//
//  ImageCache.swift
//  animeProject
//
//  Created by Nathaniel Patterson on 10/31/21.
//

import Foundation
import UIKit


class ImageCache {
    
    static let shared = ImageCache()
    private init() {}
    var imageCache: NSCache<NSString, UIImage> = NSCache()
    var runningTasks: [UUID: URLSessionTask] = [:]
    
    func read(imageStr: String) -> UIImage? {
        let nsString = imageStr as NSString
        return imageCache.object(forKey: nsString)
    }
    
    func write(imageStr: String, image: UIImage) {
        let nsString = imageStr as NSString
        imageCache.setObject(image, forKey: nsString)
    }
    
    func startFetchRequest(imageStr: String, completion: @escaping (UIImage) -> Void) -> UUID? {
        
        guard let url = URL(string: imageStr) else {
            return nil
        }
        
        let uuid = UUID()
        
        let runningTask = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                return
            }
            if let image = UIImage(data: data) {
                ImageCache.shared.write(imageStr: imageStr, image: image)
                DispatchQueue.main.async {
                    completion(image)
                }
                self.runningTasks.removeValue(forKey: uuid)
            }
            
        }
        runningTask.resume()
        runningTasks[uuid] = runningTask
        return uuid
    }
}
