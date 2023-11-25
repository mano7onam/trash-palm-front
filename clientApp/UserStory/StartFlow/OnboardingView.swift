//
//  OnboardingView.swift
//  { Module name }
//
// Created by Stanislav Zelikson on 25/11/2023.
//

import Foundation

import SwiftUI

struct OnboardingView: View {
  @EnvironmentObject var vm: AppState
  
  @State var selectedTab = 0
  var body: some View {
    TabView(selection: $selectedTab) {
      ForEach(onboardingData.indices) { index in
        OnboardingPageView(data: onboardingData[index], isLastPage: index == onboardingData.count - 1) {
          if index == onboardingData.count - 1 {
            @UserDefault("onboardingPassed", defaultValue: false)
            var onboardingPassed: Bool
            onboardingPassed = true
            vm.onboardingPassed = true
          } else {
            selectedTab += 1
          }
        }
      }
    }
    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
    .background(Color.gray)
  }
}

struct OnboardingPageView: View {
  let data: OnboardingData
  let isLastPage: Bool
  let action: () -> Void
  
  var body: some View {
    VStack {
      Image(systemName: data.imageName)
              .resizable()
              .aspectRatio(contentMode: .fit)
              .padding(30)
      Spacer().frame(height: 20)
      Text(data.title)
              .font(.title)
      Spacer().frame(height: 20)
      Text(data.description)
              .font(.subheadline)
              .foregroundColor(.gray)
              .multilineTextAlignment(.center)
              .padding()
      Spacer()
      Button(action: action) {
        Text(isLastPage ? "Finish" : "Next")
                .bold()
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
        
      }
      Spacer()
    }
  }
}