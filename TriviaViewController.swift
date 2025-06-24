//
//  TriviaViewController.swift
//  Trivia
//
//  Created by Samyam Paudel on 6/23/25.
//

import UIKit

// 1) Define a Question model
struct Question {
  let prompt: String
  let choices: [String]
  let correctIndex: Int
  let category : String
}

class TriviaViewController: UIViewController {
    
    // 2) Outlets for your UI
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonB: UIButton!
    @IBOutlet weak var buttonC: UIButton!
    @IBOutlet weak var buttonD: UIButton!
    
    // 3) Your questions array + state
    let questions: [Question] = [
        Question(prompt: "   Who won the FIFA World Cup 2014?",
                 choices: ["Brazil","Nepal","Germany","Argentina"],
                 correctIndex: 2,
                 category : "SPORTS"),
        Question(prompt: "   What’s the capital of France?",
                 choices: ["Madrid","Berlin","Paris","Rome"],
                 correctIndex: 2,
                 category: "GEOGRAPHY"),
        Question(prompt: "   What year did man land on the moon?",
                 choices: ["1965","1969","1972","1959"],
                 correctIndex: 1,
                 category: "HISTORY")
    ]
    var current = 0
    var score = 0
    
    // 4) Fill the UI with the current question
    func loadQuestion() {
        let q = questions[current]
        
        // 1) question text
        questionLabel.text = q.prompt
        
        // 2) answer buttons
        let buttons = [buttonA, buttonB, buttonC, buttonD]
        for (i, btn) in buttons.enumerated() {
            btn?.setTitle(q.choices[i], for: .normal)
            btn?.isHidden = false
        }
        
        // 3) progress “Question: 2/3”
        progressLabel.text = "Question: \(current + 1)/\(questions.count)"
        
        // 4) category “SPORTS” or “HISTORY”
        categoryLabel.text = q.category
    }
    
    // 5) On view load, show the first question
    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuestion()
    }
    
    
    // 6) This is your one IBAction—wire ALL four buttons to this
    @IBAction func answerTapped(_ sender: UIButton) {
        let buttons = [buttonA, buttonB, buttonC, buttonD]
        guard let idx = buttons.firstIndex(of: sender) else { return }
        
        // did they pick the right one?
        if idx == questions[current].correctIndex {
            score += 1
        }
        
        // move to the next question (or end)
        current += 1
        if current < questions.count {
            loadQuestion()
        } else {
            // 1) Create the alert
            let alert = UIAlertController(
                title: "Game over!",
                message: "Final score: \(score)/\(questions.count)",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "Restart", style: .default) { _ in
                  // Reset your quiz state:
                  self.current = 0
                  self.score = 0
                  self.loadQuestion()
                })

                // 3) Present it
                present(alert, animated: true, completion: nil)
        }
    }
}
