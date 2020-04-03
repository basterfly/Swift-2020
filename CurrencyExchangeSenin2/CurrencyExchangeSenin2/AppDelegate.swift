//
//  AppDelegate.swift
//  CurrencyExchangeSenin2
//
//  Created by Yegor Kozlovskiy on 1/14/20.
//  Copyright © 2020 Yegor Kozlovskiy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        Model.shared.parseXML()
        Model.shared.loadXMLFile(date: nil)
        
        return true
    }
}

