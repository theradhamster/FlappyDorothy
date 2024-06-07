//
//  ContentView.swift
//  FlappyDorothy
//
//  Created by Dorothy Luetz on 6/7/24.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    @State var showingLeaderboard = false
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: 400, height: 900)
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View {
        ZStack {
            SpriteView(scene: scene)
                .frame(width: 400, height: 900)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Button {
                        showingLeaderboard.toggle()
                    } label: {
                        Image(systemName: "trophy")
                    }
                    .font(.title3)
                    .buttonStyle(MaterialButtonStyle())
                    .padding()
                    Spacer()
                }
                Spacer()
                    .frame(height: 650)
            }
        }
        .sheet(isPresented: $showingLeaderboard) {
            LeaderboardView(showingLeaderboard: $showingLeaderboard)
        }
        .onAppear {
            GameCenterManager.shared.authenticateUser()
        }
    }
}

struct MaterialButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .foregroundColor(.primary)
      .padding()
      .background(.ultraThinMaterial)
      .cornerRadius(25)
      .scaleEffect(configuration.isPressed ? 0.9 : 1)
      .hoverEffect(.lift)
  }
}

#Preview {
    ContentView()
}
