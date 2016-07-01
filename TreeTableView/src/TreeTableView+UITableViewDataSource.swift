//
//  TreeTableView+UITableViewDataSource.swift
//  TreeTableView
//
//  Created by Yunus Eren Guzel on 30/06/16.
//  Copyright © 2016 Yunus Guezel. All rights reserved.
//

import UIKit

extension TreeTableView: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let path = paths[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(registeredCells[path.depth-1]!, forIndexPath: indexPath)
        dataSource?.treeTableView(didDequeCell: cell, forPath: path)
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paths.count
    }
    
}

extension TreeTableView: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        guard let dataSource = dataSource else { return }
        let currentIndex = indexPath.row
        paths[currentIndex].expanded = !paths[currentIndex].expanded
        let currentPath = paths[currentIndex]
        if currentPath.expanded {
            let newPaths = pathBuilder.buildPaths(dataSource, parentPath: currentPath).tail
            let indexesToBeInserted = newPaths.indices.map { NSIndexPath(forRow: $0 + currentIndex + 1, inSection: 0) }
            paths.insertContentsOf(newPaths, at: currentIndex + 1)
            tableView.insertRowsAtIndexPaths(indexesToBeInserted, withRowAnimation: .Bottom)
        } else {
            let indexesToBeRemoved = paths.indices.flatMap({ index in
                paths[index].isAncestor(currentPath) ? NSIndexPath(forRow: index, inSection: 0) : nil
            })
            paths = paths.filter { !$0.isAncestor(currentPath) }
            tableView.deleteRowsAtIndexPaths(indexesToBeRemoved, withRowAnimation: .Bottom)
            
        }
//        tableView.reloadData()
    }
    
}


