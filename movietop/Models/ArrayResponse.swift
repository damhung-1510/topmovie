//
//  ArrayResponse.swift
//  movietop
//
//  Created by Dam Hung on 21/02/2023.
//

import Foundation

struct ArrayResponse<T: Decodable>: Decodable {
    var page: Int?
    var totalReseult: Int?
    var totalPage: Int?
    var results: Array<T>?

    
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalReseult = "total_results"
        case totalPage = "total_pages"
        case results = "results"
    }

}
