//
//  FlappyEntry.swift
//  FlappyDorothy
//
//  Created by Dorothy Luetz on 6/7/24.
//

import Foundation
import GameKit

protocol FlappyEntry {
    var rank: Int { get }
    var score: Int { get }
    var alias: String { get }
}

extension GKLeaderboard.Entry: FlappyEntry {
    var alias: String {
        self.player.alias
    }
}

struct ExampleEntry: FlappyEntry {
    var rank: Int
    var score: Int
    var alias: String
    static let example = ExampleEntry(rank: 1, score: 100, alias: "Stone Gossard")
}
