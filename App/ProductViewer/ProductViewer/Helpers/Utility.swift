//
//  StandaloneListRepository.swift
//  ProductViewer
//
//  Created by Thejus G on 01/03/25.
//  Copyright © 2025 Target. All rights reserved.
//

import Foundation
import Combine

struct Utility {
    static func getProductViewerServiceBaseURL(from bundle: Bundle = .main) throws -> URL {
        guard let baseUrlString = bundle.infoDictionary?["Product Deals Base URL"] as? String, let baseUrl = URL(string: baseUrlString) else {
            throw ConfigError.missingConfig
        }
        return baseUrl
    }
}

enum ConfigError: Error {
    case missingConfig
}
