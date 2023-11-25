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
              .padding()
      Text(data.title)
              .font(.title)
      Text(data.description)
              .font(.subheadline)
              .multilineTextAlignment(.center)
              .padding()
      Button(action: action) {
        Text(isLastPage ? "Finish" : "Next")
                .bold()
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
      }
    }
  }
}