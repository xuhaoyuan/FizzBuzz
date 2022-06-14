//
//  AppDelegate.swift
//  FizzBuzz
//
//  Created by Yvette Cook on 22/10/2015.
//  Copyright © 2015 YvetteCook. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var game: FizzBuzzGame?

    private func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        game = FizzBuzzGame.sharedInstance
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        saveUserScores()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
       
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
      
    }

    func applicationWillTerminate(_ application: UIApplication) {
        saveUserScores()
    }

    func saveUserScores() {
        guard let fbGame = game else { return }
        fbGame.saveScores()
    }
    
}

