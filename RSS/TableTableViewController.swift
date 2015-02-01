//
//  TableTableViewController.swift
//  RSS
//
//  Created by Austin Eckman on 11/27/14.
//  Copyright (c) 2014 Austin Eckman. All rights reserved.
//

import UIKit
class TableTableViewController: UITableViewController, NSXMLParserDelegate, SideBarDelegate {
    
    var parser = NSXMLParser()
    var feeds = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var ftitle = NSMutableString()
    var link = NSMutableString()
    var fdescription = NSMutableString()
    var sideBar:SideBar = SideBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideBar = SideBar(sourceView: self.view, menuItems: ["First Item", "Second Item", "Third Item"])
        
        feeds = []
        var url = NSURL(string:"http://rss.cnn.com/rss/cnn_topstories.rss")
        parser = NSXMLParser(contentsOfURL: url)!
        parser.delegate = self
        parser.shouldProcessNamespaces = true
        parser.shouldReportNamespacePrefixes = true
        parser.shouldResolveExternalEntities = true
        parser.parse()

    }
    
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]!) {
        element = elementName
        
        // feed properties
        if (element as NSString).isEqualToString("item"){
            //elements = NSMutableArray.alloc()
            elements = NSMutableDictionary.alloc()
            elements = [:]
            ftitle = NSMutableString.alloc()
            ftitle = ""
            link = NSMutableString.alloc()
            link = ""
            fdescription = NSMutableString.alloc()
            fdescription = ""
        }
        
    }
    
    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!) {
        
        if (elementName as NSString).isEqualToString("item") {
            if ftitle != ""{
                elements.setObject(ftitle, forKey: "title")
            
        }
            if link != ""{
                elements.setObject(link, forKey: "link")
            
        }
            if fdescription != ""{
                elements.setObject(fdescription, forKey: "description")
            
        }
        
        feeds.addObject(elements)

    }
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!) {
        
        if element.isEqualToString("title"){
            ftitle.appendString(string)
        } else if element.isEqualToString("link"){
            link.appendString(string)
        } else if element.isEqualToString("description"){
            fdescription.appendString(string)
        }
    
    }
    
    func parserDidEndDocument(parser: NSXMLParser!) {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sideBarDidSelectButtonAtIndex(index: Int) {
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return feeds.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
    cell.textLabel?.text = feeds.objectAtIndex(indexPath.row).objectForKey("title") as? String
    cell.detailTextLabel?.numberOfLines = 3
    cell.detailTextLabel?.text = feeds.objectAtIndex(indexPath.row).objectForKey("description") as? String
        
        return cell
    }
   //ERROR Within the "var item =" not sure the correct thing to set it to
     override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //var item = self.link[indexPath.row]
        var con = KINWebBrowserViewController()
        var URL = NSURL(string: link)
        //var url = nsurl(string: item.link)
        con.loadURL(URL)
        self.navigationController?.pushViewController(con, animated: true)
    }
    


}
