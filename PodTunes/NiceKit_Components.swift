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
    var background: AbstractColor?
    
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
        
        if let background = component.background {
            if let color = background as? Color {
                NSColor(hex: color.color).set()
                NSRectFill(bounds)
            } else if let gradient = background as? Gradient {
                drawGradientBackground(gradient)
            }
        }
    }
    
    func drawGradientBackground(gradient: Gradient) {
        let color1 = NSColor(hex: gradient.colors[0])
        let color2 = NSColor(hex: gradient.colors[1])
        
        let ctx = NSGraphicsContext.currentContext()!.CGContext
        
        let drawingRect = self.bounds
        let gradient = createGradient(color1, color2: color2)
        CGContextDrawLinearGradient(ctx, gradient, CGPointMake(NSMidX(drawingRect), NSMinY(drawingRect)),
            CGPointMake(NSMidX(drawingRect), NSMaxY(drawingRect)), 0)
    }
    
    func createGradient(color1: NSColor, color2: NSColor) -> CGGradient {
        let space = CGColorSpaceCreateDeviceRGB()
        let comps1 = CGColorGetComponents(color2.CGColor)
        let comps2 = CGColorGetComponents(color1.CGColor)
        var comps = [comps1[0], comps1[1], comps1[2], comps1[3], comps2[0], comps2[1], comps2[2], comps2[3]]
        var locations: [CGFloat] = [0.0, 1.0]
        let gradient = CGGradientCreateWithColorComponents(space, &comps, &locations, 2)
        
        return gradient
    }
}



// Helpers

class AbstractColor {
}

class Color: AbstractColor {
    var color: String
    
    init(color: String) {
        self.color = color
    }
}

class Gradient: AbstractColor {
    var colors: [String]
    
    init(colors: [String]) {
        self.colors = colors
    }
}

