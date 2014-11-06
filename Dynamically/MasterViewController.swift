//
//  MasterViewController.swift
//  Dynamically
//
//  Created by joshua may on 5/11/2014.
//  Copyright (c) 2014 notjosh, inc. All rights reserved.
//

import UIKit

enum Effects: Int {
    case Gravity
    case Collapse
    case SnapToLocation
    case SnapToCentre
    case Follow
    case Cradle

    var title : String {
        switch self {
        case .Gravity:        return "Gravity"
        case .Collapse:       return "Collapse"
        case .SnapToLocation: return "SnapToLocation"
        case .SnapToCentre:   return "SnapToCentre"
        case .Follow:         return "Follow"
        case .Cradle:         return "Cradle"
        }
    }
}

class MasterViewController: UITableViewController {

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        let effect = effectAtIndex(indexPath.row)
        cell.textLabel.text = effect?.title
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier(effectAtIndex(indexPath.row)!.title, sender: self)
    }

    func effectAtIndex(idx: Int) -> Effects? {
        switch idx {
        case 0: return Effects.Gravity
        case 1: return Effects.Collapse
        case 2: return Effects.SnapToLocation
        case 3: return Effects.SnapToCentre
        case 4: return Effects.Follow
        case 5: return Effects.Cradle
        default: return nil
        }
    }
}

