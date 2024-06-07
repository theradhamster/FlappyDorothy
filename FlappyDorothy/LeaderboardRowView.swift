//
//  LeaderboardRowView.swift
//  FlappyDorothy
//
//  Created by Dorothy Luetz on 6/7/24.
//

import SwiftUI
import GameKit

struct LeaderboardRowView: View {
    let entry: any FlappyEntry
    
    var body: some View {
        HStack {
            Text("\(entry.rank). ")
            Text(entry.alias)
            Text("\(entry.score)")
        }
    }
}

#Preview {
    LeaderboardRowView(entry: ExampleEntry.example)
}
