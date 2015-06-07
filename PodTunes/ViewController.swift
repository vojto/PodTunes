//
//  ViewController.swift
//  PodTunes
//
//  Created by Vojtech Rinik on 5/21/15.
//  Copyright (c) 2015 Vojtech Rinik. All rights reserved.
//

import Cocoa
import Cartography

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        render(MainComponent(), view)
    }
}





class MainComponent: Component {
    override func render() {
        background = Color(color: "ececec")
        
        let toolbar = Toolbar()
        toolbar.height = 40
        toolbar.top = 0
        toolbar.left = 0
        toolbar.right = 0
        
        append(toolbar)
        
        
        let tabs = Tabs()
        tabs.top = 40
        tabs.height = 30
        tabs.left = 0
        tabs.right = 0
        append(tabs)
    }
}


class Toolbar: Component {
    override func render() {
        background = Gradient(colors: ["ebebeb", "cfcfcf"])
    }
}

class Tabs: Component {
    override func render() {
        background = Color(color: "fff")
    }
}