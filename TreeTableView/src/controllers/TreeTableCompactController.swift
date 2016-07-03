//
//  TreeTableCompactController.swift
//  TreeTableView
//
//  Created by Yunus Eren Guzel on 03/07/16.
//  Copyright © 2016 Yunus Guezel. All rights reserved.
//

import UIKit

internal class TreeTableCompactController: TreeTableController {
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let currentIndex = indexPath.row
        guard dataSource?.treeTableView(numberOfChildrenNodesOfPath: tree[currentIndex]) > 0 else { return }
        tree[currentIndex].expanded = !tree[currentIndex].expanded
        let currentPath = tree[currentIndex]
        
        
        if currentPath.expanded {
            
            let pathsToBeCollapsed = tree.filter { path in
                path != currentPath && !path.isAncestorOf(currentPath)
            }
            
            let indexesToBeRemoved: [NSIndexPath] = pathsToBeCollapsed.flatMap { path in
                self.tree.indices.flatMap { index in
                    self.tree[index] == path || path.isAncestorOf(self.tree[index]) ? NSIndexPath(forRow: index, inSection: 0) : nil
                }
            }
            
            tree = tree.flatMap { path in
                if pathsToBeCollapsed.any({ $0.isAncestorOf(path) }) || pathsToBeCollapsed.any({ path == $0 }) {
                    return nil
                } else {
                    return path
                }
            }
            
            let newTree = buildTree(forParentPath: currentPath)
            
            
            let translatedCurrentIndex = currentIndex - indexesToBeRemoved.reduce(0) {
                $0 + ($1.row < currentIndex ? 1 : 0)
            }
            
            let indexesToBeInserted = newTree.indices.map {
                NSIndexPath(forRow: $0 + translatedCurrentIndex + 1, inSection: 0)
            }
            
            tree.insertContentsOf(newTree, at: translatedCurrentIndex + 1)
            
            tableView.beginUpdates()
            tableView.deleteRowsAtIndexPaths(indexesToBeRemoved, withRowAnimation: .Top)
            tableView.insertRowsAtIndexPaths(indexesToBeInserted, withRowAnimation: .Top)
            tableView.endUpdates()
        } else {
            let indexesToBeRemoved = tree.indices.flatMap { index in
                currentPath.isAncestorOf(tree[index]) ? NSIndexPath(forRow: index, inSection: 0) : nil
            }
            tree = tree.filter { !currentPath.isAncestorOf($0) }
            
            
            let parentPath = tree.filter({ $0.isParentOf(currentPath) }).first
            let parentIndex = parentPath != nil ? tree.indexOf(parentPath!) ?? -1 : -1
            var pathsToBeInserted: [TreeTablePath]
            
            
            
            if let parentPath = parentPath {
                pathsToBeInserted = buildTree(forParentPath: parentPath)
            } else {
                pathsToBeInserted = buildTree()
            }
            
            let currentPathIndex = pathsToBeInserted.indexOf(currentPath)!
            let pathsToBeInsertedAbove = currentPathIndex > 0 ? pathsToBeInserted[0..<currentPathIndex] : []
            let pathsToBeInsertedBelow = (currentPathIndex < pathsToBeInserted.count - 1) ? pathsToBeInserted[(currentPathIndex+1)..<pathsToBeInserted.count] : []
            pathsToBeInserted = pathsToBeInserted.filter { $0 != currentPath }
            let indexesToBeInserted: [NSIndexPath] = pathsToBeInserted.indices.map {
                let path = pathsToBeInserted[$0]
                let row = parentIndex + 1 + path.indexes.last!
                return NSIndexPath(forRow: row, inSection: 0)
            }
            
            tree.insertContentsOf(pathsToBeInsertedAbove, at: parentIndex + 1)
            tree.insertContentsOf(pathsToBeInsertedBelow, at: tree.indexOf(currentPath)! + 1)
            
            
            
            tableView.beginUpdates()
            tableView.deleteRowsAtIndexPaths(indexesToBeRemoved, withRowAnimation: .Top)
            tableView.insertRowsAtIndexPaths(indexesToBeInserted, withRowAnimation: .Top)
            tableView.endUpdates()
        }
    }
    
}