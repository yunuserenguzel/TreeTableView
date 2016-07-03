//
//  TreeTableViewDataSource.swift
//  TreeTableView
//
//  Created by Yunus Eren Guzel on 30/06/16.
//  Copyright © 2016 Yunus Guezel. All rights reserved.
//

import UIKit

public protocol TreeTableViewDataSource: class {
    
    func treeTableView(numberOfChildrenNodesOfPath path: TreeTablePath) -> Int?
    
    func treeTableNumberOfParentNodes() -> Int
    
    func treeTableView(didDequeCell cell: UITableViewCell, forPath path: TreeTablePath)
    
    func treeTableshouldExpand(path: TreeTablePath) -> Bool
    
    func treeTableshouldCollapse(Path: TreeTablePath) -> Bool
    
}

extension TreeTableViewDataSource {
    
    func treeTableshouldExpand(path: TreeTablePath) -> Bool {
        return true
    }
    
    func treeTableshouldCollapse(Path: TreeTablePath) -> Bool {
        return true
    }
    
}
