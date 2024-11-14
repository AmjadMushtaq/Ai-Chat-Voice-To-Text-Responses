//
//  AiChatVoiceToTextApp.swift
//  AiChatVoiceToText
//
//  Created by TheSmartObject on 04/11/2024.
//


import SwiftUI
import Security

@main
struct AiChatVoiceToTextApp: App {
    @AppStorage("isFirstLaunch") private var isFirstLaunch: Bool = true // UserDefaults check

    init() {
        // If it's a first launch (either a fresh install or after uninstalling),
        // reset the Keychain onboarding flag
        if isFirstLaunch {
            resetHasSeenOnboardingInKeychain()
            isFirstLaunch = false // Set this so that next launches aren't treated as first-time
        }
    }
    
    var body: some Scene {
        WindowGroup {
            Group {
                if hasSeenOnboardingInKeychain() {
                    WelcomeView()
                } else {
                    // Show onboarding if it's the first time
                    GuideScreen1()
                        .onAppear {
                            setHasSeenOnboardingInKeychain(true) // Mark onboarding as complete
                        }
                }
            }
            .preferredColorScheme(.light)
        }
    }
}

// MARK: - Keychain Helper Functions

func hasSeenOnboardingInKeychain() -> Bool {
    return getKeychainValue(forKey: "hasSeenOnboarding") == "true"
}

func setHasSeenOnboardingInKeychain(_ value: Bool) {
    setKeychainValue(value ? "true" : "false", forKey: "hasSeenOnboarding")
}

func resetHasSeenOnboardingInKeychain() {
    setKeychainValue("false", forKey: "hasSeenOnboarding")
}

// MARK: - Keychain Access Functions

func setKeychainValue(_ value: String, forKey key: String) {
    guard let valueData = value.data(using: .utf8) else { return }
    
    let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: key,
        kSecValueData as String: valueData
    ]
    
    SecItemDelete(query as CFDictionary) // Delete any existing item
    SecItemAdd(query as CFDictionary, nil)
}

func getKeychainValue(forKey key: String) -> String? {
    let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: key,
        kSecReturnData as String: true,
        kSecMatchLimit as String: kSecMatchLimitOne
    ]
    
    var item: CFTypeRef?
    SecItemCopyMatching(query as CFDictionary, &item)
    
    if let data = item as? Data, let value = String(data: data, encoding: .utf8) {
        return value
    }
    return nil
}
