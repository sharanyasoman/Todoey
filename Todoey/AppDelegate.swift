//
//  AppDelegate.swift
//  Todoey
//
//  Created by Sharanya Soman on 30/08/19.
//  Copyright © 2019 Sharanya Soman. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//    User Defaults    print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String )
        print("Realm path:")
        print(Realm.Configuration.defaultConfiguration.fileURL as Any)
        do{
            _ = try Realm()
        }catch{
            print("Error initializing new realm, \(error)")
        }
        return true
    }


}

