import Foundation

class TutorialOneViewController: UIViewController {
    
    @IBOutlet weak var instructionLabel: UILabel!
    
    @IBOutlet weak var numberButton: UIButton!
    @IBOutlet weak var fizzButton: UIButton!
    @IBOutlet weak var buzzButton: UIButton!
    @IBOutlet weak var fizzBuzzButton: UIButton!
    
    var step1: MTutorialStep?
    var step2: MTutorialStep?
    var step3: MTutorialStep?
    var step4: MTutorialStep?
    
    var steps: [MTutorialStep]?
    
    let finalStep = 15
    
    var fizzBuzzStep = 0 {
        didSet {
            numberButton.setTitle("\(fizzBuzzStep)", for: .normal)
            guard let currentStep = tutorialStep, let steps = steps else { return }
            if fizzBuzzStep == finalStep {
                completedTutorial()
            } else if fizzBuzzStep == currentStep.triggerStep {
                tutorialStep = steps[currentStep.stepNumber + 1]
            }
        }
    }
    
    var tutorialStep: MTutorialStep? {
        didSet {
            guard let step = tutorialStep else { return }
            for button in step.visibleButtons {
                button.isHidden = false
            }
            for button in step.hiddenButtons {
                button.isHidden = true
            }
            instructionLabel.text = step.instructions
        }
    }
    
    @IBAction func numberButtonTapped(sender: UIButton) {
        guard let numberSteps = tutorialStep?.numberSteps else { return }
        if numberSteps.contains(fizzBuzzStep) {
            fizzBuzzStep+=1
        }
    }
    
    @IBAction func fizzButtonTapped(sender: UIButton) {
        guard let fizzSteps = tutorialStep?.fizzSteps else { return }
        if fizzSteps.contains(fizzBuzzStep) {
            fizzBuzzStep+=1
        }
    }
    
    @IBAction func buzzButtonTapped(sender: UIButton) {
        guard let buzzSteps = tutorialStep?.buzzSteps else { return }
        if buzzSteps.contains(fizzBuzzStep) {
            fizzBuzzStep+=1
        }    }
    
    @IBAction func ButtonTapped(sender: UIButton) {
        guard let fizzBuzzSteps = tutorialStep?.fizzBuzzSteps else { return }
        if fizzBuzzSteps.contains(fizzBuzzStep) {
            fizzBuzzStep+=1
        }
    }
    
    
    override func viewDidLoad() {
        setUpSteps()
        tutorialStep = step1
    }
    
    func completedTutorial() {
        let alert = UIAlertController(title: "Great！", message: "让我们开始玩吧", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Play", style: .default) { (action) in
            self.dismiss(animated: true)
//            self.performSegue(withIdentifier: "unwindToHome", sender: self)
        }
        alert.addAction(OKAction)
        
        self.present(alert, animated: true) {
        }
    }

    func setUpSteps() {
        step1 = MTutorialStep(
            stepNumber: 0,
            numberSteps: [0,1],
            fizzSteps: nil,
            buzzSteps: nil,
            fizzBuzzSteps: nil,
            instructions:  "你的目标是尽可能多地数数而不犯错误。",
            visibleButtons: [numberButton],
            hiddenButtons: [fizzButton, buzzButton, fizzBuzzButton],
            triggerStep: 2
        )
        
        step2 = MTutorialStep(
            stepNumber: 1,
            numberSteps: [3],
            fizzSteps: [2],
            buzzSteps: nil,
            fizzBuzzSteps: nil,
            instructions:  "如果下一个数字是3的倍数，请轻触右上角按钮",
            visibleButtons: [numberButton, fizzButton],
            hiddenButtons: [buzzButton, fizzBuzzButton],
            triggerStep: 4
        )
        
        step3 = MTutorialStep(
            stepNumber: 2,
            numberSteps: [6,7],
            fizzSteps: [5,8],
            buzzSteps: [4,9],
            fizzBuzzSteps: nil,
            instructions:  "如果下一个数字是5的倍数，请轻触左下方按钮",
            visibleButtons: [numberButton, fizzButton, buzzButton],
            hiddenButtons: [fizzBuzzButton],
            triggerStep: 10
        )
        
        step4 = MTutorialStep(
            stepNumber: 3,
            numberSteps: [10,12,13],
            fizzSteps: [11],
            buzzSteps: [],
            fizzBuzzSteps: [14],
            instructions:  "最后，如果下一个数字是3和5的倍数，请点击右下方按钮",
            visibleButtons: [numberButton, fizzButton, buzzButton, fizzBuzzButton],
            hiddenButtons: [],
            triggerStep: 15
        )
        
        steps = [step1!, step2!, step3!, step4!]
    }
    
}

struct MTutorialStep {
    let stepNumber: Int

    let numberSteps: [Int]
    let fizzSteps: [Int]?
    let buzzSteps: [Int]?
    let fizzBuzzSteps: [Int]?
    
    let instructions: String
    
    let visibleButtons: [UIButton]
    let hiddenButtons: [UIButton]
    
    let triggerStep: Int
}
