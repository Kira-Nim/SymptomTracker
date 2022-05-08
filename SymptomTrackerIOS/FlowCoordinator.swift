//
//  FlowCoordinator.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 06/05/2022.
//

import Foundation
import UIKit

/* Responsibilities:
 
    The flowCoordinator is responsible for navigation - The flowcoordinator is responsible for
    creating all controllers in the system.
 
    It is responsible for creating the initial View hierarchy and providing an root controller.
 
    When creating controllers the Flowcoordinator must provide a VM for each controller.
    To do this it needs to have acces to the ViewModelProvider.
    Controller will create their views and provide these to the given VM.
 */

class FlowCoordinator {
    
    private let viewModelProvider: ViewModelProvider
    
    func createInitialViewController() -> UIViewController {
        
        return CreateUserViewController()
    }
    
    init(viewModelProvider: ViewModelProvider) {
        self.viewModelProvider = viewModelProvider
    }
}
