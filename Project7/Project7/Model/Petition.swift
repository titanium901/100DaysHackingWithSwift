//
//  Petition.swift
//  Project7
//
//  Created by Yury Popov on 20/06/2019.
//  Copyright © 2019 Yury Popov. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
