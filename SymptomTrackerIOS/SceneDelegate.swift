//
//  SceneDelegate.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 04/05/2022.
//

import UIKit
import IQKeyboardManagerSwift

// This class has to do with UI where AppDelegate has to do with model and business logic
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    /* This method is the first to be run when the system starts.
        For configuring and attaching the UIWindow `window` to the provided UIWindowScene `scene`.
     */
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        /* Create a window of the same size (bounds) as the main screen
            A window covering the whole screen.
            A phone screen will only have something else as the main screen if a external monitor is connectes or something like that.
         */
        window = UIWindow(frame: UIScreen.main.bounds)
        
        /* Cast the param of type UIScene to a UIWindowScene if possible, else early return - UIWindowScene extends UIScene.
            Using Liskovs law - In this code we are counting on the UIScene param actually holding an instance of UIWindowScene.
            If this is not the case we will make an early return.
         
            This early return is efficient because we would not be able to use a UIScene when setting up window to be part of a Scene.
            The windowScene value shall be stored in an att. of type UIWindowScene.
         */
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window?.windowScene = windowScene
        
        /* Getting appDelegate though UIApplikation
         An instanse of AppDelegate is needed because we need to get acces to its to the ViewModelProvider instance attribute that is needed when creating a the initial contriller with the Flowcoordinator instance.
         
         UIApplication has a static variable called "shared" where a instanse of UIApplication (self) is stored (Singleton).
         We acces this variable (shared) to get access to the instance of AppDelegate stored in its attribute called "delegate".
         */
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}
        
        // The flowcoordinator is needed for setting initial controller on window
        let flowCoordinator = FlowCoordinator(viewModelProvider: appDelegate.viewModelProvider!, window: window!)
        flowCoordinator.setRootViewController()
        
        /*
         makeKeyAndVisible()
         This method tells the window that it should make itself key-window and visible on screen.
         
         windowScene
         Window expects to be part of a scene. This tells window what scene it is part of.
         This att. explaines why we, in the above, had to cast the UIScene to a UIWindowScene.
         */
        window?.makeKeyAndVisible()
        
        // Enable keyboard manager from IQKeyboardManagerSwift to handle keyboard events
        IQKeyboardManager.shared.enable = true
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}
