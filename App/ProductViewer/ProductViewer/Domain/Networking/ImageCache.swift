//
//  ImageCache.swift
//  ProductViewer
//
//  Created by Thejus G on 01/03/25.
//  Copyright © 2025 Target. All rights reserved.
//

import UIKit
import Combine

class ImageCache {
    static let shared = NSCache<NSURL, UIImage>()
}

extension UIImageView {
    private static var cancellables = [UIImageView: AnyCancellable]()
    /// Sets the image of the UIImageView from a URL.
    /// - Parameters:
    ///   - urlString: The string representation of the image URL.
    ///   - placeholder: A placeholder image to be displayed while downloading.
    func setImage(from urlString: String, placeholder: UIImage? = nil, session: URLSession = .shared) {
        // Set placeholder image if provided
        if let placeholder = placeholder {
            self.image = placeholder
        }
        
        // Ensure the URL is valid
        guard let url = URL(string: urlString) else {
            print("Invalid URL string: \(urlString)")
            return
        }
        
        // Check if the image is already cached
        if let cachedImage = ImageCache.shared.object(forKey: url as NSURL) {
            self.image = cachedImage
            return
        }
        
        // Download the image asynchronously
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        
        let cancellable = session.dataTaskPublisher(for: request)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] downloadedImage in
                guard let self = self, let image = downloadedImage else { return }
                // Cache the downloaded image
                ImageCache.shared.setObject(image, forKey: url as NSURL)
                // Update the UIImageView
                self.image = image
            }
        
        // Store the cancellable to manage the subscription's lifecycle
        UIImageView.cancellables[self] = cancellable
    }
}
