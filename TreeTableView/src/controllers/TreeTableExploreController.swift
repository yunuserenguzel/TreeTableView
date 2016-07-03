//
//  TreeTableExploreController.swift
//  TreeTableView
//
//  Created by Yunus Eren Guzel on 02/07/16.
//  Copyright © 2016 Yunus Guezel. All rights reserved.
//

import UIKit

extension Array {
    
    func any(closure: (Element) -> Bool) -> Bool {
        return reduce(false) { $0 || closure($1) }
    }
    
}

internal class TreeTableExploreController: TreeTableController {
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let currentIndex = indexPath.row
        tree[currentIndex].expanded = !tree[currentIndex].expanded
        let currentPath = tree[currentIndex]
        
        if currentPath.expanded {
            
            let newPaths = buildTree(forParentPath: currentPath)
            let indexesToBeInserted = newPaths.indices.map {
                NSIndexPath(forRow: $0 + currentIndex + 1, inSection: 0)
            }
            tree.insertContentsOf(newPaths, at: currentIndex + 1)
            tableView.insertRowsAtIndexPaths(indexesToBeInserted, withRowAnimation: .Top)
            
        } else {
            
            let indexesToBeRemoved = tree.indices.flatMap { index in
                currentPath.isAncestorOf(tree[index]) ? NSIndexPath(forRow: index, inSection: 0) : nil
            }
            tree = tree.filter { !currentPath.isAncestorOf($0) }
            tableView.deleteRowsAtIndexPaths(indexesToBeRemoved, withRowAnimation: .Top)
            
        }
        
    }
    
}






