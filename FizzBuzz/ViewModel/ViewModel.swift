//
//  ViewModel.swift
//  FizzBuzz
//
//  Created by Yvette Cook on 28/10/2015.
//  Copyright © 2015 YvetteCook. All rights reserved.
//

import UIKit

class ViewModel {
    
    let game : FizzBuzzGame!
    var vc : ViewController! {
        didSet {
            updateHighScore()
        }
    }
    
    init() {
        self.game = FizzBuzzGame.sharedInstance
    }
    
    func checkMove(move: Moves) {
        let response = game.play(move: move)
        if response.rightMove {
            vc.nextMovePrompt(score: "\(response.score)")
        } else {
            vc.gameLost()
            updateHighScore()
        }
    }
    
    func resetGame() {
        let resetScore = game.reset()
        vc.nextMovePrompt(score: "\(resetScore)")
        vc.resetGame()
    }
    
    func updateHighScore() {
        let highScore = game.getHighScore()
        vc.highScoreLabel.text = "\(highScore)"
    }
    
    func timerRunOut() {
        checkMove(move: .EndGame)
    }
}

