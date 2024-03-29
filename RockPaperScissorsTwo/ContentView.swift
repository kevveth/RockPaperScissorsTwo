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
    @State private var turns = 0
    @State private var gameIsOver = false
    
    init() {
        _cpuChoice = State(initialValue: moves[Int.random(in: 0..<3)])
        _shouldWin = State(initialValue: Bool.random())
    }
    
    // Array to store three possible moves
    let moves = ["rock", "paper", "scissors"]
    let winningMoves = ["paper", "scissors", "rock"]
    let icons = ["rps_rock", "rps_paper", "rps_scissors"]
    
    let numberOfTurns = 4
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.orange, .indigo], startPoint: .bottom, endPoint: .top)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                // Player's score
                VStack {
                    Text("Score: \(score)")
                    // App's move
                    Text("CPU's Move: \(cpuChoice)")
                    // Whether player should win or lose
                    Group {
                        if shouldWin {
                            Text("Win")
                                .foregroundStyle(.green)
                        } else {
                            Text("Lose")
                                .foregroundStyle(.red)
                        }
                    }
                    .frame(width: 100)
                    .background(.secondary)
                    .clipShape(.capsule)
                }
                .font(.largeTitle)
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
        .alert("Game Over!", isPresented: $gameIsOver) {
            Button("Reset", action: resetGame)
        } message: {
            Text("Your final score is: \(score)")
        }
    }
    
    // Handles a player's move, updates the score, and prepares for the next round
    func moveTapped(_ playerChoice: String) {
        // Find the winning move
        let winningChoice = winningMoves[moves.firstIndex(of: cpuChoice)!]
        
        // Compare the player's choice to the cpu's choice
        let didPlayerWin = playerChoice == winningChoice
        
        // Update the score
        if shouldWin == didPlayerWin {
            score += 1
        } else {
            if score > 0 {
                score -= 1
            }
        }
        
        // Update turn count and check game status
        turns += 1
        if turns == numberOfTurns { gameIsOver = true }
        
        // New choices for the next round
        cpuChoice = moves[Int.random(in: 0..<3)]
        shouldWin.toggle()
    }
    
    // Resets the game state to initial values
    func resetGame() {
        score = 0
        turns = 0
        gameIsOver = false
        cpuChoice = moves[Int.random(in: 0..<3)]
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
