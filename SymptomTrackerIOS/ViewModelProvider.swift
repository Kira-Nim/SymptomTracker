//
//  ViewModelProvider.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 06/05/2022.
//

import Foundation


// Provides VM classes for the Flowcoordinator, provides data for the VM classes.
final class ViewModelProvider {
    
    /* Manages business logic - For the model data that has been adapted to the system.
    Manages the model-adapter classes (that takes care of CRUD).
    Holds the model data classes adapted to be used throuhout the system.
    Manages the Combine pipeline
    Handles business logic
     */
    public let modelManager: ModelManager
    
    init(modelManager: ModelManager) {
        self.modelManager = modelManager
    }
    
    public func getCreateAccountViewModel() -> CreateAccountViewModel {
        return CreateAccountViewModel(modelManager: modelManager)
    }
    
    public func getLoginViewModel() -> LoginViewModel {
        return LoginViewModel(modelManager: modelManager)
    }
    
    public func getSymptomRegistrationViewModel() -> SymptomRegistrationViewModel {
        return SymptomRegistrationViewModel(modelManager: modelManager)
    }
    
    public func getAccountSettingsViewModel() -> AccountViewModel {
        return AccountViewModel(modelManager: modelManager)
    }
    
    public func getActivityViewModel() -> ActivityViewModel {
        return ActivityViewModel(modelManager: modelManager)
    }
    
    public func getInsightViewModel() -> InsightViewModel {
        return InsightViewModel(modelManager: modelManager)
    }
}
