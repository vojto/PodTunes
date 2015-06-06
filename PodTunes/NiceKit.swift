//
//  File.swift
//  PodTunes
//
//  Created by Vojtech Rinik on 5/21/15.
//  Copyright (c) 2015 Vojtech Rinik. All rights reserved.
//

import AppKit





class Button : NSButton {
    
}


class ImageButton: Button {
    init(imageName: String) {
        super.init(frame: NSZeroRect)
        
        let image = NSImage(named: imageName)
        self.image = image
        self.alternateImage = image
        self.bordered = false
        self.setButtonType(NSButtonType.MomentaryChangeButton)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}











