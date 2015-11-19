//
//  AccessoryToolbar.swift
//  CardCount
//
//  Created by Michael Luttrell on 11/18/15.
//  Copyright © 2015 Michael Luttrell. All rights reserved.
//

import UIKit

protocol ToolBarCancelDelegate {
    func canceledEntry()
}

class AccessoryToolBar: UIToolbar {
    var done = { return  }
    var cancel = { return }
    var cancelDelegate:ToolBarCancelDelegate?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func configure(done: ()->(), cancel: ()->() ){
        self.done = done
        self.cancel = cancel
        
        self.barStyle = UIBarStyle.Default
        self.translucent = false
        
        self.tintColor = UIColor(red: 204/255, green: 5/255, blue: 23/255, alpha: 1)
        self.sizeToFit()
        
        layer.borderWidth = 1.0
        layer.borderColor = UIColor(red: 0.82, green: 0.835, blue: 0.855, alpha: 1).CGColor
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: "doneEditing")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelEditing")
        
        self.setItems([cancelButton, spaceButton, doneButton], animated: false)
        self.userInteractionEnabled = true
    }
    
    func doneEditing(){
        done()
    }
    
    func cancelEditing() {
        cancelDelegate?.canceledEntry()
        cancel()
    }
    
}
