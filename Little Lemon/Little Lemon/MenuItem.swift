//
//  MenuItem.swift
//  Little Lemon
//
//  Created by Daniel Gonzalez on 2024-01-18.
//

import Foundation

struct MenuItem: Hashable, Decodable{
    //var id = UUID()
    
    let title: String
    let information: String
    let image: String
    let price: String
    let category: String
    
    
    enum CodingKeys: String, CodingKey { case
        title, image, price, category,
        information = "description"
    }
     
    
}
