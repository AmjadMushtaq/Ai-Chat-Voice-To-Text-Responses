//
//  API_key.swift
//  AiChatVoiceToText
//
//  Created by TheSmartObject on 04/11/2024.
//

import Foundation

enum APIKey {
    // Fetch the API key from 'GenerativeAPIinfo.plist'
    static var `default`: String {
        guard let filePath = Bundle.main.path(forResource: "GenerativeAPIinfo", ofType: "plist") else {
            fatalError("Couldn't find file 'GenerativeAPIinfo.plist'.")
        }
        
        let plist = NSDictionary(contentsOfFile: filePath)
        
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'GenerativeAPIinfo.plist'.")
        }
        
        if value.starts(with: "_") {
            fatalError("Follow the instructions at https://ai.google.dev/tutorials/setup to get an API key.")
        }
        
        return value
    }
}
