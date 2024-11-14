//
//  guidscreen2.swift
//  AiChatVoiceToText
//
//  Created by TheSmartObject on 11/11/2024.



import SwiftUI

// Main Guide Screen
struct GuideScreen2: View {
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text("Fast Resopons")
                        .font(.system(size: 26))
                        .bold()
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                }
                .padding(.horizontal, 70)
                .padding(.top)
                Spacer()
                
                Image("guidescreen2")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                    .padding(.bottom)
                VStack{
                    NavigationLink(destination:WelcomeView()){
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
struct GuideScreen2_Previews: PreviewProvider {
    static var previews: some View {
        GuideScreen2()
    }
}
