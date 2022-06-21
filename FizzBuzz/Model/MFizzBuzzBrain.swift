class MFizzBuzzBrain {
    
    func isDivisibleByThree(number: Int) -> Bool {
        return isDivisibleBy(number: number, divisor: 3)
    }
    
    func isDivisibleByFive(number: Int) -> Bool {
        return isDivisibleBy(number: number, divisor: 5)
    }
    
    func isDivisibleByFifteen(number: Int) -> Bool {
        return isDivisibleBy(number: number, divisor: 15)
    }
    
    func isDivisibleBy(number: Int, divisor: Int) -> Bool {
        return number % divisor == 0
    }
    
    func check(number: Int) -> Moves {
        if isDivisibleByFifteen(number: number) { return .FizzBuzz  }
        if isDivisibleByThree(number: number)   { return .Fizz      }
        if isDivisibleByFive(number: number)    { return .Buzz      }
        else { return .Number    }
    }
    
}
