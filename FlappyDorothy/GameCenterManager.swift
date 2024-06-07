//
//  GameCenterManager.swift
//  FlappyDorothy
//
//  Created by Dorothy Luetz on 6/7/24.
//

import GameKit

class GameCenterManager {
    
    static let shared = GameCenterManager()
    private let leaderboardID = "flappy"
    private(set) var isGameCenterEnabled: Bool = false
    
    func authenticateUser() {
        GKLocalPlayer.local.authenticateHandler = { vc, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
        }
    }
    func uploadScore(_ score: Int) async {
        guard GameCenterManager.shared.isGameCenterEnabled else { return }
        do {
            try await GKLeaderboard.submitScore(
                score,
                context: 0,
                player: GKLocalPlayer.local,
                leaderboardIDs: [leaderboardID]
            )
        } catch {
            print(error.localizedDescription)
        }
    }
    func fetchLeaderboardEntries() async -> [GKLeaderboard.Entry] {
        var entries: [GKLeaderboard.Entry] = []
        
        do {
            let leaderboards  = try await GKLeaderboard.loadLeaderboards(IDs: [leaderboardID])
            if let leaderboard = leaderboards.first(where: {$0.baseLeaderboardID == leaderboardID}) {
                let leaderboardEntries = try await leaderboard.loadEntries(for: .global, timeScope: .allTime, range: NSRange(1...100))
                entries = leaderboardEntries.1
            }
        } catch {
            print(error.localizedDescription)
        }
        return entries
    }
}
