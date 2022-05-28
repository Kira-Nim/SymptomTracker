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
    public let inputIsToLongError = "Den maksimal længde symptomets navn er 55 anslag"
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
    public let createSymptomButtonText = "Nyt Symptom"
    public let AllDayRegistrationButtonText = "Overordnet"
    
    //MARK: Placeholder text
    public let emailPlaceholderText = "Email"
    public let passwordPlaceholderText = "Password"
    public let passwordRepeatPlaceholderText = "Gentag password"
    
    //MARK: Name of app "Logo" text
    public let appTitle = "Symptom Tracker"
    
    //MARK: Labels
    public let createSymptomLabelText = "Symptom navn"
    
    //MARK: Tabbar labels
    public let tabbarAccountText = "Indstillinger"
    public let tabbarInsightText = "Overblik"
    public let tabbarRegistrationsText = "Symptomer"
    public let tabbarActivityText = "Aktiviteter"
    
    // Controller titles
    public let symptomListControllerTitle = "Symptom Liste"
    public let editSymptomControllerTitle = "Rediger navn"
    public let createSymptomControllerTitle = "Opret Symptom"

    // Symptomer
    public let headache = "Hovedpine"
    public let dizziness = "Svimmelhed"
    public let nausea = "Kvalme"
    public let soundSensitivity = "Lysfølsomhed"
    public let lightSensitivity = "Lysfølsomhed"
    public let impairedVision = "Nedsat synsfunktionalitet"

    public let neckPain = "Nakkesterter"
    public let jointPain = "Ondt i led"
    public let pressureInTheHead = "Trykken i hovedet"
    public let ringingInTheHead = "Rungen i hovedet"
    public let overactiveNervousSystem = "Overaktivt nerve system"
    public let muscleTension = "Muskel spændinger"
    public let alcoholIntolerance = "Alkohol intolerance"

    public let extremeFatigue = "Ekstrem træthed"
    public let delayedFatigue = "Forsinket træthed"
    public let quickExhaustion = "Hurtig udtrætning"
    public let seizureFatigue = "Anfaldstræthed"
    public let stressFatigue = "Belastningstræthed"
    public let alteredSleep = "Ændret søvn"
    public let insomnia = "Insomnia"
    public let hypersomnia = "Hypersomnia"
    
    public let stress = "Stress"
    public let difficultyPayingAttention = "Opmærksomhedsbesvær"
    public let learningDifficulties = "Indlærings vanskeligheder"
    public let impairedVisionRegistration = "Nedsat synsregistrering"
    public let decisionFatigue = "Beslutningstræthed"
    public let slowThinking = "Langsom tænkning"
    public let slowResponsiveness = "Langsom reaktionsevne"
    public let difficultyConcentrating = "Koncentrationsbesvær"
    public let reducedSensoryFilter = "Reduceret sensorisk filter"
    public let memoryProblems = "MemoryProblems"
    public let difficultiesUsingTheWorkingMemory = "Vanskeligheder med arbejdshukommelsen"
    public let reducedExecutiveFunctions = "Nedsat eksekutive funktioner"
    public let reducedReadinessForChange = "Nedsat omstillingsparathed"
    
    public let sadness = "Tristhed"
    public let severeAnxciety = "Angst"
    public let mildAnxciety = "Ængstelighed"
    public let irritability = "Irritabelhed"
    public let aggression = "Agression"
    public let moodChanges = "Humørsvingninger"
    public let difficultyWithEmotionalControl = "problemer med emotionel kontrol"
    public let changedPersonality = "Ændret personlighed"
}
