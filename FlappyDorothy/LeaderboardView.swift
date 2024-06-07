//
//  LeaderboardView.swift
//  FlappyDorothy
//
//  Created by Dorothy Luetz on 6/7/24.
//

import SwiftUI
import GameKit

struct LeaderboardView: View {
    @State var entries: [GKLeaderboard.Entry] = []
    @Binding var showingLeaderboard: Bool
    var contentUnavailableMessage: String {
        GameCenterManager.shared.isGameCenterEnabled ? "Record a score 👅" : "Log in to iCloud or else 👹"
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("hellcavernresized")
                    .ignoresSafeArea()
                List(entries, id: \.self) { entry in
                    LeaderboardRowView(entry: entry)
                }
                .scrollContentBackground(.hidden)
                .refreshable {
                    Task {
                        entries = await GameCenterManager.shared.fetchLeaderboardEntries()
                    }
                }
                .overlay {
                    if entries.isEmpty {
                        VStack {
                            Image("devilme")
                            Text("There are no scores...")
                                .foregroundStyle(.red)
                                .padding()
                                .background(.thinMaterial)
                        }
                    }
                }
                .onAppear {
                    Task {
                        entries = await GameCenterManager.shared.fetchLeaderboardEntries()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showingLeaderboard.toggle()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .buttonStyle(MaterialButtonStyle())
                }
            }
        }
    }
}

#Preview {
    LeaderboardView(showingLeaderboard: ContentView().$showingLeaderboard)
}
