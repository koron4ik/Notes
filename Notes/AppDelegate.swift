//
//  AppDelegate.swift
//  Notes
//
//  Created by Vadim Koronchik on 3/11/19.
//  Copyright © 2019 Vadim Koronchik. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    let popover = NSPopover()
    var eventMonitor: EventMonitor?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
//        UserDefaults.standard.set(true, forKey: "NSConstraintBasedLayoutVisualizeMutuallyExclusiveConstraints")
        
        if let button = statusItem.button {
            let size = CGSize(width: button.frame.width - 4, height: button.frame.height - 4)
            button.image = NSImage(named: "statusBarButton")?.resizeTo(size)
            button.action = #selector(togglePopover)
        }
        
        popover.contentViewController = TaskViewController.freshController()
        
        eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown]) { [weak self] event in
            if let self = self, self.popover.isShown {
                self.closePopover(sender: event)
            }
        }
    }
    
    @objc func togglePopover(_ sender: Any?) {
        popover.isShown ? closePopover(sender: sender) : showPopover(sender: sender)
    }
    
    func showPopover(sender: Any?) {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            eventMonitor?.start()
        }
    }
    
    func closePopover(sender: Any?) {
        popover.performClose(sender)
        eventMonitor?.stop()
    }
    
//    func constructMenu() {
//        let menu = NSMenu()
//
//        menu.addItem(NSMenuItem(title: "Print Quote", action: #selector(AppDelegate.printQuote), keyEquivalent: ""))
//        menu.addItem(NSMenuItem.separator())
//        menu.addItem(NSMenuItem(title: "Quit Quotes", action: #selector(NSApplication.terminate), keyEquivalent: "q"))
//
//        statusItem.menu = menu
//    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

