//
//  Guide screen.swift
//  AiChatVoiceToText
//
//  Created by TheSmartObject on 11/11/2024.
//


import SwiftUI

// Main Guide Screen
struct GuideScreen1: View {
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text("Personal AI Chatbot Assistant")
                        .font(.system(size: 26))
                        .bold()
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                }
                .padding(.horizontal, 70)
                .padding(.top, 30)
                
                Spacer()
                
                Image("guidescreen1")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                    .padding(.bottom)
                
                VStack {
                    NavigationLink(destination: GuideScreen2()) {
                        Text("Next")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.btcolor)
                            .foregroundColor(.black)
                            .bold()
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true) // Hide the back button
        
    }
}

// Preview for GuideScreen
struct GuideScreen1_Previews: PreviewProvider {
    static var previews: some View {
        GuideScreen1()
    }
}
