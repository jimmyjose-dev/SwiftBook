//
//  ViewController.swift
//  SwiftBookSearch
//
//  Created by Jimmy Jose on 05/06/14.
//  Copyright (c) 2014 Varshyl Mobile Pvt. Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITextFieldDelegate{
    
    @IBOutlet var textField:UITextField = UITextField()
   
    var array:NSArray = NSArray ()
    var data:NSMutableData = NSMutableData ()
    var tableData:NSArray = NSArray()
    var hud:MBProgressHUD = MBProgressHUD()
    
    
    @IBAction func searchButtonPressed(){
        
        textField.resignFirstResponder()
        println(textField.text)
        
        hud.labelText = "Searching for \(textField.text)"
        hud.detailsLabelText = "Please wait...."
        hud.show(true)
        self.view.addSubview(hud)
        
        
        searchItunes(textField.text)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidEndEditing(textField: UITextField!) {
    
        textField.resignFirstResponder()
        
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
         textField.resignFirstResponder()
         println(textField.text)
        return true
    
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    

        var list:ListResultTable = segue.destinationViewController as ListResultTable
        list.tableData = self.tableData
        list.count = 3
        
        println("\(segue.identifier) \(list.count)")
        
    }
    
    func searchItunes(appname: NSString){
        
        var appStoreAppName = appname.stringByReplacingOccurrencesOfString(" ", withString: "+")
        
        var urlPath = "http://it-ebooks-api.info/v1/search/"+appStoreAppName
        //var urlPath = "https://itunes.apple.com/search?term=\(appStoreAppName)&media=software"
        
        var url: NSURL = NSURL(string: urlPath)
        
        var request:NSURLRequest = NSURLRequest(URL: url)
        
        var connection:NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)
        
        connection.start()
        
        
        println(appStoreAppName)
        
    }
    
  
    
    func connection(connection: NSURLConnection!, didFailWithError error: NSError!) {
        println("Connection failed.\(error.localizedDescription)")
    }
    
    func connection(connection: NSURLConnection, didRecieveResponse response: NSURLResponse)  {
        println("Recieved response")
    }
    
    
    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        // Recieved a new request, clear out the data object
        self.data = NSMutableData()
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        // Append the recieved chunk of data to our data object
        self.data.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        // Request complete, self.data should now hold the resulting info
        // Convert it to a string
        var dataAsString: NSString = NSString(data: self.data, encoding: NSUTF8StringEncoding)
        
        // Convert the retrieved data in to an object through JSON deserialization
        var err: NSError
        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        println(jsonResult["Total"])
        
        var total:NSString = jsonResult["Total"] as NSString
        hud.removeFromSuperview()
        if !total.isEqualToString("0") {
            var results: NSArray = jsonResult["Books"] as NSArray
            self.tableData = results
            self.performSegueWithIdentifier("ListResult", sender: nil)
           
            //hud.show(false)
            
            
        }
        
    }
    

}

