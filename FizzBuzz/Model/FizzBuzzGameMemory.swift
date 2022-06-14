//
//  FizzBuzzGameMemory.swift
//  FizzBuzz
//
//  Created by Yvette Cook on 09/11/2015.
//  Copyright © 2015 YvetteCook. All rights reserved.
//

import Foundation

class GameMemory: NSObject {
    
    lazy var scoreStore: ScoreStore = {
        do {
            guard let data = UserDefaults.standard.data(forKey: "scoreStore") else {
                return ScoreStore(scores: [], highScore: 0)
            }
            return try JSONDecoder().decode(ScoreStore.self, from: data)
        } catch {
            return ScoreStore(scores: [], highScore: 0)
        }
    }()
    
    override init(){
        super.init()
    }
    
    func storeScore(score: Int) {
        scoreStore.storeScore(score: score)
    }
    
    func getHighScore() -> Int {
        return scoreStore.highScore
    }
    
    func saveScores() {
        do {
            let data = try JSONEncoder().encode(scoreStore)
            UserDefaults.standard.set(data, forKey: "scoreStore")
        } catch {
            print(error.localizedDescription)
        }
    }
}

class ScoreStore: NSObject, Codable {
    var scores: [Int]
    var highScore : Int

    init(scores: [Int], highScore: Int){
        self.scores = scores
        self.highScore = highScore
    }
    
    func storeScore(score: Int) {
        scores.append(score)
        updateHighScore()
    }
    
    func updateHighScore() {
        let sortedScores = scores.sorted(by: { $0 < $1 })
        highScore = sortedScores.last ?? 0
    }
}
