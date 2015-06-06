//
//  TableView.swift
//  PodTunes
//
//  Created by Vojtech Rinik on 5/21/15.
//  Copyright (c) 2015 Vojtech Rinik. All rights reserved.
//

import AppKit


class TableView : NSScrollView, NSTableViewDataSource, NSTableViewDelegate {
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        let tableView = NSTableView(frame: NSZeroRect)
        
        let column1 = NSTableColumn(identifier: "column1")
        column1.width = 150
        (column1.headerCell as! NSCell).stringValue = "Column 1"
        
        let column2 = NSTableColumn(identifier: "column2")
        column2.width = 150
        (column2.headerCell as! NSCell).stringValue = "Column 2"
        
        tableView.addTableColumn(column1)
        tableView.addTableColumn(column2)
        
        
        self.documentView = tableView
        
        
        tableView.setDataSource(self)
        tableView.setDelegate(self)
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return 10
    }
    
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        return "foo"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}