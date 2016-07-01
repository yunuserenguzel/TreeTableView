//
//  TreeTableViewDataSource.swift
//  TreeTableView
//
//  Created by Yunus Eren Guzel on 30/06/16.
//  Copyright © 2016 Yunus Guezel. All rights reserved.
//

import UIKit

protocol TreeTableViewDataSource: class {
    
    func treeTableView(numberOfChildrenNodesOfPath path: TreeTablePath) -> Int?
    
    func numberOfParentNodes() -> Int
    
    func treeTableView(didDequeCell cell: UITableViewCell, forPath path: TreeTablePath)
    
}
