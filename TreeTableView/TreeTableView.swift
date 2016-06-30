//
//  TreeTableView.swift
//  TreeTableView
//
//  Created by Yunus Guezel on 30/06/16.
//  Copyright © 2016 Yunus Guezel. All rights reserved.
//

import UIKit

protocol TreeTableViewDataSource: class {
    
    func treeTableView(treeTableView _: TreeTableView, numberOfChildrenNodesOfPath Path: TreeTablePath) -> Int?
    
    func numberOfParentNodes(treeTableView _: TreeTableView) -> Int
    
}

struct TreeTablePath {
    
    let indexes: [Int]
    var parentIndex: Int! {
        return indexes.first
    }
    var tailPath: TreeTablePath? {
        return TreeTablePath(indexes: indexes.tail)
    }
    
    func childPathAtIndex(index: Int) -> TreeTablePath {
        return TreeTablePath(indexes: indexes + [index])
    }
}

class TreeTableView: UIView {
    
    private lazy var tableView = UITableView(frame: CGRect.zero, style: .Plain)
    
    private var paths = [TreeTablePath]()
    
    weak var dataSource: TreeTableViewDataSource?
    
    private func numberOfNodes() -> Int {
        return paths.count
    }

    private func buildPaths() {
        let numberOfParentNodes = dataSource?.numberOfParentNodes(treeTableView: self) ?? 0
        paths = (0..<numberOfParentNodes).flatMap { TreeTablePath(indexes: [$0]) }
    }
    
    private func nodeTree(parentPath: TreeTablePath) -> [TreeTablePath] {
        guard let numberOfChildren = dataSource?.treeTableView(treeTableView: self, numberOfChildrenNodesOfPath: parentPath) where numberOfChildren > 0 else { return [parentPath] }
        return [parentPath] + numberOfChildren.toRange().flatMap { self.nodeTree(parentPath.childPathAtIndex($0)) }
    }
    
}

extension TreeTableView: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
}

extension Int {
    
    func toRange() -> Range<Int> {
        return (0..<self)
    }
    
}

extension Array {
    
    var tail: [Element] {
        let range = (0..<count)
        return Array(self[range])
    }
    
}





