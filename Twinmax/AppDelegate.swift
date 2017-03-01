//
//  AppDelegate.swift
//  Twinmax
//
//  Created by Baptiste KAROLEWSKI on 22/09/2016.
//  Copyright © 2016 ISEN. All rights reserved.
//

import UIKit
import CoreBluetooth

var btDelegate: CBCentralManagerDelegate?
var btManager: CBCentralManager?
var peripheralDelegate: CBPeripheralDelegate?
var peripheralDevice: CBPeripheral?
var frameDecoder: FrameDecoder?
var cylinders = Array(repeating: [Double](), count: 4)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
  

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let iconHistorique = UIApplicationShortcutIcon(templateImageName: "Historique-1")
        let iconModeEmploi = UIApplicationShortcutIcon(templateImageName: "Mode d'emploi")

        let historiqueShortcut = UIMutableApplicationShortcutItem(type: "Historique",
                                                         localizedTitle: "Historique",
                                                         localizedSubtitle: "",
                                                         icon: iconHistorique,
                                                         userInfo: nil
        )
        
        let modeEmploiShortcut = UIMutableApplicationShortcutItem(type: "Mode d'emploi",
                                                                  localizedTitle: "Mode d'emploi",
                                                                  localizedSubtitle: "",
                                                                  icon: iconModeEmploi,
                                                                  userInfo: nil
        )
        application.shortcutItems = [historiqueShortcut, modeEmploiShortcut]
        
//        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        btDelegate = CentralManagerDelegate()
        btManager = CBCentralManager(delegate: btDelegate, queue: nil)
        frameDecoder = FrameDecoder()
        peripheralDelegate = PeripheralDelegate()

        return true
    }
    
//    func rotated() {
//        if (UIDeviceOrientationIsLandscape(UIDevice.current.orientation)) {
//            print("landscape")
//        }
//        if (UIDeviceOrientationIsPortrait(UIDevice.current.orientation)) {
//            print("Portrait")
//        }
//    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        
        // Get root navigation controller + root tab bar controller
        let tabbarController = window!.rootViewController as? UITabBarController
        
        switch shortcutItem.type {
        case "Historique":
            tabbarController!.selectedViewController = tabbarController!.viewControllers?[2]
        case "Mode d'emploi":
            tabbarController!.selectedViewController = tabbarController!.viewControllers?[3]
            
        default:
            tabbarController!.selectedViewController = tabbarController!.viewControllers?[0]
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

