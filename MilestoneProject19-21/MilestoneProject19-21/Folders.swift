//
//  Folders.swift
//  MilestoneProject19-21
//
//  Created by Yury Popov on 18/07/2019.
//  Copyright © 2019 Yury Popov. All rights reserved.
//

import Foundation


class Folders: Codable {
    var folders: [Folder]
    init(folders: [Folder]) {
        self.folders = folders
    }
    
}

class Folder: Codable {
    var name: String
    var notes: [Note]
    init(name: String, notes: [Note]) {
        self.name = name
        self.notes = notes
    }
    
    

}

class Note: Codable {
    var name: String
    var text: String
    
    init(name: String, text: String) {
        self.name = name
        self.text = text
    }
}

class Singleton {
    
    static var shared: Singleton!
    private init() {}
    
    func save(_ folders: [Folder]) {
        let defaults = UserDefaults.standard
        let data = folders.map { try? JSONEncoder().encode($0)}
        defaults.set(data, forKey: "saveFolders")
    }
    
    func loadData() -> [Folder] {
        let defaults = UserDefaults.standard
        guard let encodeData = defaults.array(forKey: "saveFolders") as? [Data] else {
            return []
        }
        
        return encodeData.map { try! JSONDecoder().decode(Folder.self, from: $0) }
    }
}
