//
//  ContentView.swift
//  RockPaperScissorsTwo
//
//  Created by Kenneth Oliver Rathbun on 2/13/24.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @State private var cpuChoice = ""
    @State private var shouldWin = false
    @State private var score = 0
    
    init() {
        _cpuChoice = State(initialValue: moves.randomElement()!)
    }
    
    // Array to store three possible moves
    //    let moves = ["🗿", "📜", "✂️"]
    let moves = ["rock", "paper", "scissors"]
    let winningMoves = ["paper", "scissors", "rock"]
    let icons = ["rps_rock", "rps_paper", "rps_scissors"]
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.orange, .gray], startPoint: .bottom, endPoint: .top)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                // Player's score
                VStack {
                    Text("Score: \(score)")
                    // App's move
                    Text("CPU's Move: \(cpuChoice)")
                    // Whether player should win or lose
                    if shouldWin {
                        Text("Win")
                    } else {
                        Text("Lose")
                    }
                }
                .padding()
                .textCase(.uppercase)
                
                Spacer()
                
                // 3 Buttons to choose from
                VStack {
                    ForEach(0..<3) { index in
                        Button {
                            moveTapped(moves[index])
                        } label: {
                            RPSImage(move: icons[index])
                            
                        }
                    }
                    .padding()
                }
                Spacer()
            }
            
        }
    }
    
    func moveTapped(_ playerChoice: String) {
        // Find the winning move
        let winningChoice = winningMoves[moves.firstIndex(of: cpuChoice)!]
        
        // Compare the player's choice to the cpu's choice
        let didPlayerWin = playerChoice == winningChoice
        
        // Update the score
        if shouldWin == didPlayerWin {
            score += 1
        } else {
            score -= 1
        }
        
        // New choices for the next round
        cpuChoice = moves.randomElement()!
        shouldWin.toggle()
    }
}

struct RPSImage: View {
    var move: String
    
    var body: some View {
        Image(move)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 180, height: 90, alignment: .center)
            .clipShape(.capsule)
            .shadow(radius: 10)
    }
}



#Preview {
    ContentView()
}
