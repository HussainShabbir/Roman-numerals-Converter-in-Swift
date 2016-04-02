//
//  ViewController.swift
//  RomanNumeralsMapping
//
//  Created by Hussain  on 31/3/16.
//  Copyright © 2016 Hussain . All rights reserved.
//

import UIKit

class RnmViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any addvaronal setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        return kRomannumeralsconversion
    }
    
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String?{
        return kTableViewFooterMessage
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier(kReuseIdentifier) as! RnmCustomInputTableViewCell
        cell.representedObject = self
        return cell
    }
}

