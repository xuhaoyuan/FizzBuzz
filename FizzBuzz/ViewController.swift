import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scoreButton: UIButton!
    @IBOutlet weak var fizzButton: UIButton!
    @IBOutlet weak var buzzButton: UIButton!
    @IBOutlet weak var fizzBuzzButton: UIButton!
    
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var hsLabel: UILabel!
    @IBOutlet weak var multiplesButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var background: UIView!
    
    var gameTime = 30.0
    
    var fluidView: BAFluidView!
    var gameTimer: Timer?
    
    let viewModel = ViewModel()
    var state = UIState.Ready {
        didSet {
            toggleState()
        }
    }
    
    var playButtons: [UIButton]!
    var fbButtons: [UIButton]!
    var settingsViews: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.vc = self
        playButtons = [scoreButton, fizzButton, buzzButton, fizzBuzzButton]
        fbButtons = [fizzButton, buzzButton, fizzBuzzButton]
        settingsViews = [highScoreLabel, hsLabel, multiplesButton, settingsButton, playButton]
    }
    
    // MARK: Input Actions
    
    @IBAction func tapped(sender: UIButton) {
        if state != .Playing {
            state = .Playing
        }
        switch sender {
        case scoreButton:
            checkMove(move: .Number)
        case fizzButton:
            checkMove(move: .Fizz)
        case buzzButton:
            checkMove(move: .Buzz)
        case fizzBuzzButton:
            checkMove(move: .FizzBuzz)
        default:
            break
        }
    }
    
    func checkMove(move: Moves) {
        viewModel.checkMove(move: move)
    }
    
    @IBAction func playAgain(sender: UIButton) {
        viewModel.resetGame()
    }
    
    
    // MARK: Output Actions
    
    func nextMovePrompt(score: String) {
        scoreButton.setTitle(score, for: .normal)
    }
    
    func gameLost() {
        self.state = .Lost
        guard let timer = gameTimer else { return }
        timer.invalidate()
    }
    
    func setBackgroundColorTo(color: UIColor) {
        self.background.backgroundColor = color
    }
    
    // MARK: State
    
    func toggleState() {
        switch state {
        case .Ready:
            setBackgroundColorTo(color: FizzBuzzColors.readyBackgroundColor)
            enablePlayButtons()
            showSettingsButtons()
            showFizzBuzzButtons()
        case .Playing:
            setUpFluidLayer()
            startTimer()
            setBackgroundColorTo(color: FizzBuzzColors.activeBackgroundColor)
            enablePlayButtons()
            showFizzBuzzButtons()
            hideSettingsButtons()
        case .Lost:
            setBackgroundColorTo(color: FizzBuzzColors.lostBackgroundColor)
            disablePlayButtons()
            showSettingsButtons()
            removeFluidView()
            hideFizzBuzzButtons()
        }
    }
    
    func resetGame() {
        state = .Ready
    }
    
    func disablePlayButtons() {
        for button in playButtons {
            button.isUserInteractionEnabled = false
        }
    }
    
    func enablePlayButtons() {
        for button in playButtons {
            button.isUserInteractionEnabled = true
        }
    }
    
    func hideSettingsButtons() {
        for view in settingsViews {
            view.isHidden = true
        }
    }

    func showSettingsButtons() {
        for view in settingsViews {
            view.isHidden = false
        }
    }
    
    func hideFizzBuzzButtons() {
        for button in fbButtons {
            button.isHidden = true
        }
    }
    
    func showFizzBuzzButtons() {
        for button in fbButtons {
            button.isHidden = false
        }
    }
    
    func startTimer() {
        gameTimer = Timer(timeInterval: gameTime, target: self, selector:#selector(timerFinished), userInfo: nil, repeats: false)
        RunLoop.current.add(gameTimer!, forMode: .common)
    }
    
    @objc func timerFinished() {
        viewModel.timerRunOut()
    }
    
    func stopTimer() {
        gameTimer?.invalidate()
    }
    
    // MARK: Segue
    
    @IBAction func unwindToHome2(sender: UIStoryboardSegue) {
    }

}

extension ViewController {
    
    // MARK: FLuidAnimation
    
    func setUpFluidLayer() {
        fluidView = BAFluidView(frame: self.background.frame, startElevation: 0.0)
        fluidView.fillDuration = gameTime
        fluidView.fill(to: 0.983)
        fluidView.fillColor = FizzBuzzColors.timerBackgroundColor
        fluidView.fillRepeatCount = 1
        fluidView.fillAutoReverse = false
        self.background.addSubview(fluidView)
    }
    
    func pauseFluidView() {
        fluidView.keepStationary()
        fluidView.stopAnimation()
    }

    func playFluidView() {
        fluidView.startAnimation()
    }
    
    func removeFluidView() {
        fluidView.removeFromSuperview()
        fluidView = nil
    }
    
}

