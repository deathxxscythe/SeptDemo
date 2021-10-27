//
//  ImageCache.swift
//  drinksCache
//
//  Created by Luat on 8/23/21.
//

import UIKit

/// Todo: Save each image

class ImageCache {
    
    static let shared = ImageCache()
    private init() {}
    
    var imageCache: NSCache<NSString, UIImage> = NSCache()
    var runningTasks: [String: URLSessionDataTask] = [:]
    
    func read(imageStr: String) -> UIImage? {
        let nsString = imageStr as NSString
        return imageCache.object(forKey: nsString)
    }
    
    func write(imageStr: String, image: UIImage) {
        let nsString = imageStr as NSString
        imageCache.setObject(image, forKey: nsString)
    }
    
    func startFetchRequest(imageStr: String, completion: @escaping (UIImage) -> Void) -> String? {
        guard let url = URL(string: imageStr) else {
            return nil
        }
        let runningTask = URLSession.shared.dataTask(with: url) { data, resp, error in
            guard let data = data else {
                return
            }
            if let image = UIImage(data: data) {
                ImageCache.shared.write(imageStr: imageStr, image: image)
                DispatchQueue.main.async {
                    completion(image)
                }
                /// 3. Remove tasks from dictionary so we know task is DONE
                self.runningTasks.removeValue(forKey: imageStr)
            }
            guard let error = error, (error as NSError).code == NSURLErrorCancelled else {
                /// - Task CANCELLED --> Handle in some way
                return
            }
        }
        runningTask.resume()
        /// 2. Save tasks to dictionary so we know task is in progress
        runningTasks[imageStr] = runningTask
        /// - Task STARTING -> Returns the imageStr
        return imageStr
    }
    
    
}
