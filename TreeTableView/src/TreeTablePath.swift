//
//  TreeTableViewPath.swift
//  TreeTableView
//
//  Created by Yunus Eren Guzel on 30/06/16.
//  Copyright © 2016 Yunus Guezel. All rights reserved.
//

import Foundation

struct TreeTablePath {
    
    let indexes: [Int]
    var expanded: Bool
    
    init(indexes: [Int], expanded: Bool = false) {
        self.indexes = indexes
        self.expanded = expanded
    }
    
}

extension TreeTablePath {
    
    var depth: Int {
        return indexes.count
    }
    
    var parentIndex: Int! {
        return indexes.first
    }
    
    var tailPath: TreeTablePath? {
        return TreeTablePath(indexes: indexes.tail)
    }
    
    func childPathAtIndex(index: Int) -> TreeTablePath {
        return TreeTablePath(indexes: indexes + [index])
    }
    
    func isAncestor(path: TreeTablePath) -> Bool {
        guard depth > path.depth && path.depth > 0 else { return false }
        return path.indexes.indices.reduce(true) { $0 && self.indexes[$1] == path.indexes[$1] }
    }

}