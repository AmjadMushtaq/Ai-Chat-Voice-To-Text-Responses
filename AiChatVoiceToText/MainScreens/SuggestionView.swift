
//  SuggestionView.swift
//  AiChatVoiceToText
//
//  Created by TheSmartObject on 07/11/2024.
//
import SwiftUI

struct SuggestionView: View {
    let prompts = [
        "How to make $100 in a day",
        "What's a good way to start the day?",
        "How do I organize my tasks?",
        "What are some healthy breakfast ideas?",
        "How can I stay focused while studying?",
        "What’s a quick way to relieve stress?",
        "Any tips for a better sleep routine?",
        "How can I be more productive at work?",
        "Suggestions for managing work-life balance?",
        "What are good conversation starters?",
        "How do I plan a budget-friendly meal?",
        "How can I improve my fitness routine?",
        "What's a quick way to boost my mood?",
        "How can I manage time better?",
        "Tips for planning a weekend trip?",
        "How do I keep track of my expenses?",
        "What are some ways to practice gratitude?",
        "How can I deal with procrastination?",
        "Any tips for making new friends?",
        "What's a good way to unwind after work?",
        "How do I set realistic goals?",
        "Suggestions for maintaining mental health?",
        "How can I save money daily?",
        "What's a simple way to meditate?",
        "How can I improve my communication skills?",
        "Any ideas for family bonding activities?",
        "How do I stay motivated?",
        "What are some eco-friendly practices?",
        "How can I reduce screen time?",
        "What’s a good self-care routine?",
        "How can I improve my posture?",
        "Suggestions for eating mindfully?",
        "How do I keep a positive attitude?",
        "What’s a good way to organize my home?",
        "How do I avoid burnout?",
        "Tips for a healthy work-from-home setup?",
        "How can I make more time for hobbies?",
        "What’s a quick way to de-stress?",
        "How can I eat healthier on a budget?",
        "What's a good way to build confidence?",
        "Suggestions for daily mindfulness?",
        "How can I be more present with loved ones?",
        "Any advice for a successful morning routine?",
        "How can I track my goals more effectively?",
        "What’s a simple way to exercise daily?",
        "How do I manage anxiety?",
        "Any tips for meal prepping?",
        "How can I be more environmentally conscious?",
        "Suggestions for improving concentration?",
        "How do I boost my creativity?",
        "Any ideas for a digital detox?",
        "How can I stay calm in stressful situations?",
        "What are some easy home workouts?",
        "How can I manage social media use?",
        "Any tips for improving relationships?",
        "Suggestions for practicing mindfulness?",
        "How do I stay hydrated effectively?",
        "What’s a good way to reflect on my day?",
        "How can I improve my productivity at home?",
        "What are some easy stress-relief activities?",
        "How do I reduce distractions?",
        "Tips for being more organized?",
        "How can I build a better morning routine?",
        "Any ideas for practicing daily gratitude?",
        "How do I stay active at home?",
        "Suggestions for improving self-discipline?",
        "How can I make healthier food choices?",
        "Any tips for managing emotions?",
        "What are some ways to celebrate small wins?",
        "How can I stay focused on my goals?",
        "Any ideas for creative hobbies?",
        "How do I improve my sleep quality?",
        "What’s a good way to start journaling?",
        "Suggestions for staying motivated?",
        "How do I practice self-compassion?",
        "Any tips for finding joy in everyday life?",
        "What’s a quick way to stay active?",
        "How can I improve my study habits?",
        "Suggestions for reducing clutter?",
        "How can I build resilience?",
        "What’s a good way to end the day?",
        "Any advice for developing patience?",
        "How can I practice daily affirmations?",
        "Tips for making meals more nutritious?",
        "What are some small acts of kindness?",
        "How can I stay positive during challenges?",
        "Any ideas for outdoor activities?",
        "How can I make better financial decisions?",
        "What’s a good way to refresh my mind?",
        "How do I develop a growth mindset?",
        "Suggestions for reducing waste?",
        "Any tips for practicing kindness daily?",
        "How can I stay active without a gym?",
        "What’s a good way to unwind after a busy day?",
        "How can I build a consistent sleep schedule?",
        "What are some ways to build inner peace?",
        "How do I manage my energy levels?",
        "Suggestions for practicing empathy?",
        "Any ideas for strengthening relationships?",
        "How can I create a balanced lifestyle?",
        "What’s a simple way to start the day positively?"
    ]
    @Binding var selectedPrompt: String
    var onPromptSelected: () -> Void
    
    
    var body: some View {
        NavigationView {
            List(prompts, id: \.self) { prompt in
                Text(prompt)
                    .padding(.vertical, 5)
                    .onTapGesture {
                        selectedPrompt = prompt
                        onPromptSelected() // Dismiss the sheet
                        
                    }
            }
        }
    }
}
 


// MARK: Dummy Ad View
/*
import SwiftUI
struct DummyAdView: View {
    var body: some View {
        VStack {
            Text("Sponsored Ad")
                .font(.headline)
                .padding(.top, 5)
            Text("This is a placeholder for an ad.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom, 5)
        }
        .frame(maxWidth: .infinity)
        .background(Color(.systemGray6))
        .cornerRadius(8)
        .padding(.vertical, 10)
    }
}

// SuggestionView displaying the prompts and ads
struct SuggestionView: View {
    let prompts = [
        "How to make $1000 in a day",
        "What's a good way to start the day?",
        "How do I organize my tasks?",
        "What are some healthy breakfast ideas?",
        "How can I stay focused while studying?",
        "What’s a quick way to relieve stress?",
        "Any tips for a better sleep routine?",
        "How can I be more productive at work?",
        "Suggestions for managing work-life balance?",
        "What are good conversation starters?",
        "How do I plan a budget-friendly meal?",
        "How can I improve my fitness routine?",
        "What's a quick way to boost my mood?",
        "How can I manage time better?",
        "Tips for planning a weekend trip?",
        "How do I keep track of my expenses?",
        "What are some ways to practice gratitude?",
        "How can I deal with procrastination?",
        "Any tips for making new friends?",
        "What's a good way to unwind after work?",
        "How do I set realistic goals?",
        "Suggestions for maintaining mental health?",
        "How can I save money daily?",
        "What's a simple way to meditate?",
        "How can I improve my communication skills?",
        "Any ideas for family bonding activities?",
        "How do I stay motivated?",
        "What are some eco-friendly practices?",
        "How can I reduce screen time?",
        "What’s a good self-care routine?",
        "How can I improve my posture?",
        "Suggestions for eating mindfully?",
        "What’s a good way to organize my home?",
        "How do I avoid burnout?",
        "Tips for a healthy work-from-home setup?",
        "How can I make more time for hobbies?",
        "What’s a quick way to de-stress?",
        "How can I eat healthier on a budget?",
        "What's a good way to build confidence?",
        "Suggestions for daily mindfulness?",
        "How can I be more present with loved ones?",
        "Any advice for a successful morning routine?",
        "How can I track my goals more effectively?",
        "What’s a simple way to exercise daily?",
        "How do I manage anxiety?",
        "Any tips for meal prepping?",
        "How can I be more environmentally conscious?",
        "Suggestions for improving concentration?",
        "How do I boost my creativity?",
        "Any ideas for a digital detox?",
        "How can I stay calm in stressful situations?",
        "What are some easy home workouts?",
        "How can I manage social media use?",
        "Any tips for improving relationships?",
        "Suggestions for practicing mindfulness?",
        "How do I stay hydrated effectively?",
        "What’s a good way to reflect on my day?",
        "How can I improve my productivity at home?",
        "What are some easy stress-relief activities?",
        "How do I reduce distractions?",
        "Tips for being more organized?",
        "How can I build a better morning routine?",
        "Any ideas for practicing daily gratitude?",
        "How do I stay active at home?",
        "Suggestions for improving self-discipline?",
        "How can I make healthier food choices?",
        "Any tips for managing emotions?",
        "What are some ways to celebrate small wins?",
        "How can I stay focused on my goals?",
        "Any ideas for creative hobbies?",
        "How do I improve my sleep quality?",
        "What’s a good way to start journaling?",
        "Suggestions for staying motivated?",
        "How do I practice self-compassion?",
        "Any tips for finding joy in everyday life?",
        "What’s a quick way to stay active?",
        "How can I improve my study habits?",
        "Suggestions for reducing clutter?",
        "How can I build resilience?",
        "What’s a good way to end the day?",
        "Any advice for developing patience?",
        "How can I practice daily affirmations?",
        "Tips for making meals more nutritious?",
        "What are some small acts of kindness?",
        "How can I stay positive during challenges?",
        "Any ideas for outdoor activities?",
        "How can I make better financial decisions?",
        "What’s a good way to refresh my mind?",
        "How do I develop a growth mindset?",
        "Suggestions for reducing waste?",
        "Any tips for practicing kindness daily?",
        "How can I stay active without a gym?",
        "What’s a good way to unwind after a busy day?",
        "How can I build a consistent sleep schedule?",
        "What are some ways to build inner peace?",
        "How do I manage my energy levels?",
        "Suggestions for practicing empathy?",
        "Any ideas for strengthening relationships?",
        "How can I create a balanced lifestyle?",
        "What’s a simple way to start the day positively?"
    ]
    
    @Binding var selectedPrompt: String
    var onPromptSelected: () -> Void

    var body: some View {
        NavigationView {
            List {
                ForEach(prompts.indices, id: \.self) { index in
                    let prompt = prompts[index]
                    
                    // Display the prompt
                    Text(prompt)
                        .padding(.vertical, 5)
                        .onTapGesture {
                            selectedPrompt = prompt
                            onPromptSelected()
                        }
                    
                    // Insert a dummy ad view after every 10 prompts
                    if (index + 1) % 20 == 0 {
                        DummyAdView()
                    }
                }
            }
        }
    }
}
*/

