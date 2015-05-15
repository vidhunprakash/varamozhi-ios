//
//  MasterViewController.swift
//  VaramozhiEditor
//
//  Created by jijo pulikkottil on 12/23/14.
//  Copyright (c) 2014 jeesmon. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = ["Setup & Usage", "Transliteration", "User Guide", "About"]//NSMutableArray(), "Preview"
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as [NSObject : AnyObject]
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.tableView.rowHeight = 100
        // Do any additional setup after loading the view, typically from a nib.
        /*self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        */
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*func insertNewObject(sender: AnyObject) {
        objects.insertObject(NSDate(), atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }*/

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let isPad = UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad
        
        //if isPad {
        
        
        if segue.identifier == "showDetail" {
            
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                
                
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.modeDisplay = indexPath.row
                
                if indexPath.row == 0 {
                    
                    let object = NSBundle.mainBundle().pathForResource("installation", ofType: "html")
                    
                    
                    
                    controller.filePath = object
                }else if indexPath.row == 2 {
                    
                    let object = NSBundle.mainBundle().pathForResource("lipi", ofType: "png")
                    
                    
                    
                    controller.filePath = object
                }
                else if indexPath.row == 3 {
                    let object = NSBundle.mainBundle().pathForResource("info", ofType: "html")
                    
                    
                    
                    controller.filePath = object
                    
                }
                //controller.configureView()
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
                
                
                
                
                let orientation = UIApplication.sharedApplication().statusBarOrientation
                
                if orientation.isPortrait {
                    
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    appDelegate.hideMasterOnPortrait()
                    // Portrait
                } else {
                    // Landscape
                }
                
                
                
            }
        }else if segue.identifier == "showPreview" {
            
            
            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController2
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
            controller.navigationItem.leftItemsSupplementBackButton = true
            
            let orientation = UIApplication.sharedApplication().statusBarOrientation
            
            if orientation.isPortrait {
                
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.hideMasterOnPortrait()
                // Portrait
            } else {
                // Landscape
            }
            
        }else{
            
            
        }
        
    
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var ident = "Cell"
        if indexPath.row == 1 {
            
            ident = "CellEditor"
            
        }
        let cell = tableView.dequeueReusableCellWithIdentifier(ident, forIndexPath: indexPath) as! UITableViewCell

        let viewBg: UIView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 100))
        viewBg.backgroundColor = UIColor(red: 102/255, green: 172/255, blue: 96/255, alpha: 1)
        cell.selectedBackgroundView = viewBg
        
        let object = objects[indexPath.row] as String
        cell.textLabel!.textColor = UIColor(red: 102/255, green: 172/255, blue: 96/255, alpha: 1) //102, 172, 96
        cell.textLabel!.textAlignment = NSTextAlignment.Center
        cell.textLabel!.text = object
        
        return cell
    }
    /*override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        if indexPath.row == 1 {
            self.performSegueWithIdentifier("showPreview", sender: self)
            
            
        } else  {
            self.performSegueWithIdentifier("showDetail", sender: self)
        }
      
        
    }*/
    /*
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    */

}

