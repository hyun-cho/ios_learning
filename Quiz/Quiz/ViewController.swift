//
//  ViewController.swift
//  Quiz
//
//  Created by NHN on 2021/04/08.
//

import UIKit

class ViewController: UIViewController {
    
    //UIView
    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuestionLabel.text = quiz[quizIndex]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nextQuestionLabel.alpha = 0
    }
    
    
    let quiz: [String] = ["1 + 1", "너의 이름은", "사는 곳은"]
    let answers: [String] = ["2", "조종현", "서울"]
    var quizIndex: Int = 0
    
    func updateQuiz() {
        nextQuestionLabel.text = quiz[quizIndex]
        answerLabel.text = "???"
        animateLabelTransitions()
    }

    func animateLabelTransitions() {
        // 실행만 시킬뿐, 종료를 기다리지 않는다.
        UIView.animate(withDuration:1.5, animations:  {
            // 애니메이션이 1 > 0 > 1 순으로 일어나게 하려면?
            self.currentQuestionLabel.alpha = 0
            self.nextQuestionLabel.alpha = 1
        })
    }
    
    
    
//    @IBOutlet var questionLabel: UILabel!
    // 한 라벨이 두 UILbael을 가리키고 있는데, 어떤식으로 작동하는지?
    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    
    @IBAction func showNextQuiz(_ sender: Any) {
        quizIndex += 1
        if quizIndex == quiz.count {
            quizIndex = 0
        }
        updateQuiz()
    }
    
    @IBAction func showCurrentAnswer(_ sender: Any) {
        answerLabel.text = answers[quizIndex]
    }
}

