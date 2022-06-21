import Foundation

class MFizzBuzzGame: NSObject {
    
static let sharedInstance = MFizzBuzzGame()
    
    var score : Int!
    let brain : MFizzBuzzBrain!
    let memory : MGameMemory!
    
    override init(){
        score = 0
        brain = MFizzBuzzBrain()
        memory = MGameMemory()
        super.init()
    }
    
    func play(move: Moves) -> MoveReponse {
        let newScore = score + 1
        if move == brain.check(number: newScore) {
            score = newScore
            return MoveReponse(rightMove: true, score: score)
        } else {
            memory.storeScore(score: score)
            return MoveReponse(rightMove: false, score: score)
        }
    }
    
    func reset() -> Int {
        score = 0
        return score
    }
    
    func getHighScore() -> Int {
        return memory.getHighScore()
    }
    
    func saveScores() {
        memory.saveScores()
    }
    
}

enum Moves {
    case Number, Fizz, Buzz, FizzBuzz, EndGame
}

struct MoveReponse {
    let rightMove: Bool
    let score: Int
}





