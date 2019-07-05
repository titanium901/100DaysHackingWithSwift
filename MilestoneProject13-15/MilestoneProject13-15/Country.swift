//
//  Country.swift
//  MilestoneProject13-15
//
//  Created by Yury Popov on 05/07/2019.
//  Copyright © 2019 Yury Popov. All rights reserved.
//

import Foundation
// MARK: - Countries
struct Countries: Codable {
    let countries: [Country]
}

// MARK: - Country
struct Country: Codable {
    let name, capital: String
    let population, area: Int
    let currency: String
}
