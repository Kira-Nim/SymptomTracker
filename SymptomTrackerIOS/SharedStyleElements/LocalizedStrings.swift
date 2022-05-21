//
//  LocalizedStrings.swift
//  SymptomTrackerIOS
//
//  Created by Kira Nim on 20/05/2022.
//

import Foundation

final class LocalizedStrings {
    static let shared = LocalizedStrings()
    
    //MARK:  Error messages
    public let repeatPasswordError = "Gentag password fejlede"
    public let accountCreationFailedError = "Fejl ved oprettelse af bruger"
    public let emailAlreadyExistError = "Den valgte email eksisterer allerede"
    public let invalidEmailError = "Fejl med den valgte email"
    public let weakPasswordError = "Password skal indeholde minimum 6 tegn"
    public let emptyEmailFieldError = "Angiv email"
    public let emptyFieldError = "Udfyld alle felterne"
    public let invalidCredentialsError = "Forkert email eller password"
    public let loginFailedError = "Fejl ved login"
    public let accountDisabledError = "Kontoen er blevet lukket"
    
    //MARK: Confirmation messages
    public let passwordResetConfirmation = "Der er sendt en email. Følg linket i mailen for at vælge et nyt password."
    
    //MARK: Strings shown on buttons and other clickable elements
    public let x = "✕"
    public let logOutButtonText = "Log ud"
    public let loginButtonText = "login"
    public let resetPasswordButtonText = "Nulstil Password"
    public let createAccountClickableLabelText = "Opret konto"
    public let forgotPasswordClickableLabetText = "Glemt password"
    public let createAccountButtonText = "Opret"
    public let settingsListSymptomListItem = "Symptom List"
    
    //MARK: Placeholder text
    public let emailPlaceholderText = "Email"
    public let passwordPlaceholderText = "Password"
    public let passwordRepeatPlaceholderText = "Gentag password"
    
    //MARK: Name of app "Logo" text
    public let appTitle = "Symptom Tracker"
    
    //MARK: Tabbar labels
    public let tabbarAccountText = "Indstillinger"
    public let tabbarInsightText = "Overblik"
    public let tabbarRegistrationsText = "Symptomer"
    public let tabbarActivityText = "Aktiviteter"
    
    // Controller titles
    public let symptomListControllerTitle = "Symptom Liste"

}
