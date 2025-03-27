//
//  TagModel.swift
//  MemoraCoreData
//
//  Created by Fabian Rodriguez on 26/3/25.
//

struct TagModel {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    init(_ tag: Tag) {
        self.name = tag.name ?? ""
    }
}
