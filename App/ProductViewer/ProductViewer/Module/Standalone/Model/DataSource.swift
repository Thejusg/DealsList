//
//  Copyright © 2022 Target. All rights reserved.
//

import UIKit

struct ProductList: Codable {
    var products: [Product]
    enum CodingKeys: String, CodingKey {
        case products
    }
}

struct Product: Codable {
    var id: Int
    var title: String
    var aisle: String
    var description: String
    var imageUrl: String?
    var regularPrice: Price?
    var salePrice: Price?
    var fulfillment: String
    var availability: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case aisle
        case description
        case imageUrl = "image_url"
        case regularPrice = "regular_price"
        case salePrice = "sale_price"
        case fulfillment
        case availability
    }
}

struct Price: Codable {
    var amount_in_cents: Double?
    var currency_symbol: String?
    var display_string: String?
}
