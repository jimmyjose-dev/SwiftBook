//
//  ListResultTable.swift
//  SwiftBookSearch
//
//  Created by Jimmy Jose on 05/06/14.
//  Copyright (c) 2014 Varshyl Mobile Pvt. Ltd. All rights reserved.
//

import UIKit

class ListResultTable : UITableViewController, UITableViewDataSource, UITableViewDelegate{

     @IBOutlet var tableview:UITableView = UITableView()

    var count:Int = 0
    
    var tableData:NSArray = NSArray()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section:    Int) -> Int {
        return self.tableData.count
    }
    
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "BookCell")
        
        var dictTable:NSDictionary = tableData[indexPath.row] as NSDictionary
        
       // var imageView:FXImageView = FXImageView()
        

        cell.text = dictTable["Title"] as NSString

        cell.detailTextLabel.text = dictTable["Description"] as NSString
        
        var urlString:NSString = dictTable["Image"] as NSString
        
        var url:NSURL = NSURL(string: urlString)
        
        
        var imageData:NSData = NSData(contentsOfURL: url)
        
        var image:UIImage = UIImage(data: imageData)
        
        cell.imageView.image = image
        
        //imageView.setImageWithContentsOfURL(url)
        
        //cell.contentView.addSubview(imageView)

        

        return cell
    }
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!){
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        var frame:CGRect = CGRectMake(0, 0, 45, 45)
        var vw:UIView = UIView(frame: frame)
        
        
        var cell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)
        frame.size.height = cell.imageView.frame.size.height
        frame.size.width = cell.imageView.frame.size.width
        
        
        vw.frame = frame
        var imageView:UIImageView = UIImageView(image: cell.imageView.image)
        
        vw.addSubview(imageView)
        
        vw.center = self.view.center
        
        tableView.addSubview(vw)
        println("pressed")
        
        
        
    }
    


}
