//
//  AppDelegate.swift
//  MenuBarDesignPrinciple
//
//  Created by KakiageSeiro on 2018/12/20.
//  Copyright © 2018 kakiage.seiro. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    // ①メニューアイコンとアイコンから表示するPopoverを用意
    private let menuBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    private let popover = NSPopover()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // ②ボタンにアイコン画像とアクションを指定
        if let button = self.menuBarItem.button {
            button.image = NSImage(named: NSImage.Name("MenuBarIcon"))
            button.action = #selector(togglePopover(_:))
        }
        // ③Popoverで表示するViewを指定
        self.popover.contentViewController = ViewController.freshController()
    }
}

// ②ボタンにアイコン画像とアクションを指定
extension AppDelegate {
    @objc func togglePopover(_ sender: Any) {
        if self.popover.isShown {
            self.closePopover(sender)
        } else {
            self.showPopover(sender)
        }
    }
    
    func showPopover(_ sender: Any) {
        guard let button = self.menuBarItem.button else { return }
        self.popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
    }
    
    func closePopover(_ sender: Any) {
        self.popover.performClose(sender)
    }
}

// ③Popoverで表示するViewを指定
extension ViewController {
    static func freshController() -> ViewController {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let identifier: NSStoryboard.SceneIdentifier = "ViewController"
        guard let viewController = storyboard.instantiateController(withIdentifier: identifier) as? ViewController else { fatalError("...") }
        return viewController
    }
}

