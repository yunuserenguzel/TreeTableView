//
//  TreeTableViewPath.swift
//  TreeTableView
//
//  Created by Yunus Eren Guzel on 30/06/16.
//  Copyright © 2016 Yunus Guezel. All rights reserved.
//

import Foundation

public struct TreeTablePath: Equatable, CustomStringConvertible {
    
    let indexes: [Int]
    var expanded: Bool
    
    init(indexes: [Int], expanded: Bool = false) {
        self.indexes = indexes
        self.expanded = expanded
    }
    
}

public func ==(lhs: TreeTablePath, rhs: TreeTablePath) -> Bool {
    return lhs.indexes == rhs.indexes
}

typealias Tree = [TreeTablePath]

extension TreeTablePath {
    
    var collapsed: Bool {
        get {
            return !expanded
        }
        set(newValue) {
            expanded = !newValue
        }
    }
    
    var depth: Int {
        return indexes.count
    }
    
    var rootIndex: Int! {
        return indexes.first
    }
    
    var tailPath: TreeTablePath? {
        return TreeTablePath(indexes: indexes.tail)
    }
    
    func childPathAtIndex(index: Int) -> TreeTablePath {
        return TreeTablePath(indexes: indexes + [index])
    }
    
    func isAncestorOf(child: TreeTablePath) -> Bool {
        guard depth < child.depth else { return false }
        return indexes.indices.reduce(true) { $0 && self.indexes[$1] == child.indexes[$1] }
    }
    
    func isParentOf(child: TreeTablePath) -> Bool {
        guard depth == child.depth - 1 else { return false }
        return indexes.indices.reduce(true) { $0 && self.indexes[$1] == child.indexes[$1] }
    }

    public var description: String {
        return "Path: " + indexes.reduce("") { $0 + "\($1)" }
    }
    
}