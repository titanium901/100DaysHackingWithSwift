//
//  Person.swift
//  Project10
//
//  Created by Yury Popov on 27/06/2019.
//  Copyright © 2019 Yury Popov. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
