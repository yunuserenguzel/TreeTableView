//
//  PathBuilder.swift
//  TreeTableView
//
//  Created by Yunus Eren Guzel on 01/07/16.
//  Copyright © 2016 Yunus Guezel. All rights reserved.
//

import Foundation


protocol PathBuilder: class {
    
    func buildPaths(dataSource: TreeTableViewDataSource) -> [TreeTablePath]
    func buildPaths(dataSource: TreeTableViewDataSource, parentPath: TreeTablePath) -> [TreeTablePath]
}


class ExplorePathBuilder: PathBuilder {
    
    func buildPaths(dataSource: TreeTableViewDataSource) -> [TreeTablePath] {
        let numberOfParentNodes = dataSource.numberOfParentNodes()
        return (0..<numberOfParentNodes).flatMap {
            self.buildPaths(dataSource, parentPath: TreeTablePath(indexes: [$0]))
        }
    }
    
    func buildPaths(dataSource: TreeTableViewDataSource, parentPath: TreeTablePath) -> [TreeTablePath] {
        guard let numberOfChildren = dataSource.treeTableView(numberOfChildrenNodesOfPath: parentPath)
            where numberOfChildren > 0 else { return [parentPath] }
        if parentPath.expanded {
            return [parentPath] + numberOfChildren.toRange().flatMap { self.buildPaths(dataSource, parentPath:parentPath.childPathAtIndex($0)) }
        } else {
            return [parentPath]
        }
    }
    
}