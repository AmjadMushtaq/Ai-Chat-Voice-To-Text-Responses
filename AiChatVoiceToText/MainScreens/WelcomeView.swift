//
//  WelcomeView.swift
//  AiChatVoiceToText
//
//  Created by TheSmartObject on 11/11/2024.
//


import SwiftUI
import Lottie

struct WelcomeView: View {
    @State private var isVisible = false

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    // Lottie Animation
                    LottieView(lottieFile: "Welcomeanimation")
                        .frame(width: 300, height: 300)
                        .opacity(isVisible ? 1 : 0)
                        .scaleEffect(isVisible ? 1 : 2)
                        .animation(.easeIn(duration: 1), value: isVisible)

                    Spacer() // This spacer pushes the content above it upwards

                    Text("Welcome to AI Personal Assistant")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding()
                        .opacity(isVisible ? 1 : 0)
                        .scaleEffect(isVisible ? 1 : 0.5)
                        .animation(.easeIn(duration: 1), value: isVisible)

                    Spacer() // This spacer pushes the button to the bottom

                    NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true)) {
                        Text("Continue")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.btcolor)
                            .foregroundColor(.black)
                            .bold()
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, geometry.safeAreaInsets.bottom + 20) // Add padding to the bottom for safe area
                }
                .padding() // Add padding to the VStack to ensure content doesn't touch the edges
                .background(Color.clear)
                .onAppear {
                    isVisible = true
                }
            }
        }
        .navigationBarBackButtonHidden(true)

    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
