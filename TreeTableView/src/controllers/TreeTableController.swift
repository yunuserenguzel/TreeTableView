//
//  TreeTableController.swift
//  TreeTableView
//
//  Created by Yunus Eren Guzel on 02/07/16.
//  Copyright © 2016 Yunus Guezel. All rights reserved.
//

import UIKit

internal class TreeTableController: NSObject {
    
    weak var dataSource: TreeTableViewDataSource? {
        didSet {
            dispatch_async(dispatch_get_main_queue()) {
                self.tree = self.buildTree()
                self.tableView.reloadData()
            }
        }
    }
    
    let tableView: UITableView
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
    }
    
    internal var tree = [TreeTablePath]()
    
    internal var registeredCells = [Int: String]()
    
    func registerCell(depth depth: Int, identifier: String) {
        registeredCells[depth] = identifier
    }
    
    
    func cellIdentifier(forIndexPath indexPath: NSIndexPath) -> String {
        return registeredCells[tree[indexPath.row].depth-1]!
    }
    
    private func numberOfNodes() -> Int {
        return tree.count
    }
    
    func buildTree() -> Tree {
        let numberOfParentNodes = dataSource!.treeTableNumberOfParentNodes()
        return (0..<numberOfParentNodes).map { TreeTablePath(indexes: [$0]) }
    }
    
    func buildTree(forParentPath parentPath: TreeTablePath) -> Tree {
        guard let numberOfChildren = dataSource!.treeTableView(numberOfChildrenNodesOfPath: parentPath)
            where numberOfChildren > 0 else { return [] }
        let result = numberOfChildren.toRange().map { parentPath.childPathAtIndex($0) }
        return result
    }

}


extension TreeTableController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = cellIdentifier(forIndexPath: indexPath)
        let path = tree[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
        dataSource?.treeTableView(didDequeCell: cell, forPath: path)
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tree.count
    }
    
}

extension TreeTableController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
}


