//
//  AppDelegate.swift
//  lab
//
//  Created by Ilya Androsav on 2/2/21.
//

import UIKit
import Firebase
import GoogleMaps
import GooglePlaces
import LanguageManager_iOS

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        GMSServices.provideAPIKey("AIzaSyAUqhSTswjILv7kYJCLQM_5xDdmvaTyAP4")
        GMSPlacesClient.provideAPIKey("AIzaSyAUqhSTswjILv7kYJCLQM_5xDdmvaTyAP4")
        LanguageManager.shared.defaultLanguage = .en
        LanguageManager.shared.setLanguage(language: .en)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

