//
//  PhoneContentView.swift
//  BackOff!!!Mobile
//
//  Created by Maanasvi Kotturi on 3/3/25.
//

import SwiftUI

struct PhoneContentView: View {
    var body: some View {
        NavigationView {
            //code that has to do with UI formatting
            VStack(spacing: 40) {Image("Back_Off_Logo_v1")
                    .resizable(capInsets: EdgeInsets(top: -3.0, leading: -1.0, bottom: -3.0, trailing: -3.0))
                Text("Welcome!!!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, -1.0)
//Button that takes you to the Analytics Screen
                NavigationLink(destination: AnalyticsView()) {
                    Text("Analytics")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 150, height: 90)
                        .background(RoundedRectangle(cornerRadius: 25)
                            .fill(Color.blue))
                        .shadow(radius: 5)
                }
            }
            .navigationTitle("Home")
        }
    }
}

struct PhoneContentView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneContentView()
    }
}
