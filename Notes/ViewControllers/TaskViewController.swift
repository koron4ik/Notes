//
//  ViewController.swift
//  Notes
//
//  Created by Vadim Koronchik on 3/11/19.
//  Copyright © 2019 Vadim Koronchik. All rights reserved.
//

import Cocoa

class TaskViewController: NSViewController {
    
    @IBOutlet var topView: NSView!
    @IBOutlet var newTaskButton: NSButton!
    @IBOutlet var tasksButton: NSButton!
    
    var bottomButtonLine: NSView!
    var tabViewController: NSTabViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        topView.wantsLayer = true
        topView.layer?.backgroundColor = CGColor.black
        
        newTaskButton.wantsLayer = true
        tasksButton.wantsLayer = true

        newTaskButton.layer?.backgroundColor = CGColor.black
        
        tasksButton.contentTintColor = NSColor.gray
        tasksButton.layer?.backgroundColor = CGColor.black
        
        bottomButtonLine = NSView()
        bottomButtonLine.translatesAutoresizingMaskIntoConstraints = false
        configureBottomLineConstraints(to: newTaskButton)
        bottomButtonLine.wantsLayer = true
        bottomButtonLine.layer?.backgroundColor = CGColor(red: 0/255, green: 255/255, blue: 255/255, alpha: 1.0)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction func newTaskButtonPressed(_ sender: Any) {
        newTaskButton.contentTintColor = NSColor.white
        tasksButton.contentTintColor = NSColor.gray
        configureBottomLineConstraints(to: newTaskButton)
        tabViewController?.selectedTabViewItemIndex = 0
    }
    
    @IBAction func tasksButtonPressed(_ sender: Any) {
        newTaskButton.contentTintColor = NSColor.gray
        tasksButton.contentTintColor = NSColor.white
        configureBottomLineConstraints(to: tasksButton)
        tabViewController?.selectedTabViewItemIndex = 1
    }
    
    private func configureBottomLineConstraints(to button: NSButton) {
        bottomButtonLine.removeFromSuperview()
        topView.addSubview(bottomButtonLine)
        bottomButtonLine.leadingAnchor.constraint(equalTo: button.leadingAnchor).isActive = true
        bottomButtonLine.trailingAnchor.constraint(equalTo: button.trailingAnchor).isActive = true
        bottomButtonLine.heightAnchor.constraint(equalToConstant: 3).isActive = true
        bottomButtonLine.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 2).isActive = true
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        guard segue.identifier == "TabView",
            let tabViewController = segue.destinationController as? NSTabViewController else {
                return
        }
        
        self.tabViewController = tabViewController
    }
}

extension TaskViewController {
    
    // MARK: Storyboard instantiation
    static func freshController() -> TaskViewController {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let identifier = "TaskViewController"

        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? TaskViewController else {
            fatalError("identifier isn't correct")
        }
        return viewcontroller
    }
}
