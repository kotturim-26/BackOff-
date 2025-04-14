//
//  ContentView.swift
//  BackOff!!!Mobile
//
//  Created by Maanasvi Kotturi on 3/3/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            // Evaluator comment: This VStack handles the main UI layout; consider separating concerns if the view grows in complexity.
            VStack(spacing: 40) {
                
                // App logo display
                Image("Back_Off_Logo_v1")
                    .resizable(
                        capInsets: EdgeInsets(top: -3.0, leading: -1.0, bottom: -3.0, trailing: -3.0)
                    )
                
                // Welcome title text
                Text("Welcome!!!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, -1.0)
                // Evaluator comment: Avoid negative horizontal padding; it can cause layout issues on different devices.

                // Navigation button to AnalyticsView
                NavigationLink(destination: AnalyticsView()) {
                    Text("Analytics")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 150, height: 90)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.blue)
                        )
                        .shadow(radius: 5)
                }
                // Evaluator comment: Add `.accessibilityLabel("View Analytics")` to improve VoiceOver accessibility.
            }
            .navigationTitle("Home")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
