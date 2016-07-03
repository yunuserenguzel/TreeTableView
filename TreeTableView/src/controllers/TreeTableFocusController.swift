//
//  TreeTableFocusedController.swift
//  TreeTableView
//
//  Created by Yunus Eren Guzel on 03/07/16.
//  Copyright © 2016 Yunus Guezel. All rights reserved.
//

import UIKit


internal class TreeTableFocusController: TreeTableController {
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let currentIndex = indexPath.row
        tree[currentIndex].expanded = !tree[currentIndex].expanded
        let currentPath = tree[currentIndex]
        if currentPath.expanded {
            
            let pathsToBeCollapsed = tree.filter { path in
                path.expanded && path != currentPath && !path.isAncestorOf(currentPath)
            }
            
            let indexesToBeRemoved = tree.indices.flatMap({ index in
                pathsToBeCollapsed.any({ $0.isAncestorOf(self.tree[index]) }) ? NSIndexPath(forRow: index, inSection: 0) : nil
            })
            
            tree = tree.flatMap { path in
                if pathsToBeCollapsed.any({ $0.isAncestorOf(path) }) {
                    return nil
                }
                else if pathsToBeCollapsed.any({ path == $0 }) {
                    var collapsedPath = path
                    collapsedPath.collapsed = true
                    return collapsedPath
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
            tableView.deleteRowsAtIndexPaths(indexesToBeRemoved, withRowAnimation: .Top)
        }
    }
    
}
