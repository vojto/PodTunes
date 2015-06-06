//
//  NiceKit_Components.swift
//  PodTunes
//
//  Created by Vojtech Rinik on 6/6/15.
//  Copyright (c) 2015 Vojtech Rinik. All rights reserved.
//

import AppKit
import Cartography


func render(component: Component, parentView: NSView) {
    // Parse component structure, create a view for each
    // set attributes from component, set up sizing
    // and insert. Whew.
    
    // This is rendering root element, we set it to take up entire view
    
    // TODO: Set to take up entire view
    
    component.top = 0
    component.right = 0
    component.bottom = 0
    component.left = 0
    
    component.mount(parentView)
    
    
}

class Component: NSObject {
    // Sizing
    var width: Number?
    var height: Number?
    var top: Number?
    var right: Number?
    var bottom: Number?
    var left: Number?
    
    // Style
    var background: String?
    
    var children: [Component] = []
    
    // View
    var view: NSView?
    
    required override init() {
        super.init()
        
        println("creating component instance")
    }
    
    func render() {
    }
    
    func append(component: Component) {
        children.append(component)
    }
    
    private func mount(parentView: NSView) {
        render()
        
        println("Rendered component: \(self)")
        
        view = ComponentView(component: self)
        
        parentView.addSubview(view!)
        
        self.layout()
        
        // Take every children of this component and render them
        // into newly created view of current component
        for child in children {
            child.mount(view!)
        }
    }
    
    private func layout() {
        println("Laying out \(self)")
        
        Cartography.layout(view!.superview!, view!) { parent, view in
            if let top = self.top {
                view.top == parent.top + top
            }
            
            if let right = self.right {
                view.right == parent.right + right
            }
            
            if let bottom = self.bottom {
                view.bottom == parent.bottom + bottom
            }
            
            if let left = self.left {
                view.left == parent.left + left
            }
            
            if let width = self.width {
                view.width == width
            }
            
            if let height = self.height {
                view.height == height
            }
        }
    }
}



class ComponentView: NSView {
    let component: Component
    
    init(component: Component) {
        self.component = component
        
        super.init(frame: NSZeroRect)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(dirtyRect: NSRect) {
        let background = component.background
        
        println("Drawing component view with background: \(background)")
        
        if background != nil {
            NSColor(hex: background!).set()
            NSRectFill(bounds)
        }
    }
}