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
        
        // 애니메이션을 위한 라벨위치 이동
        updateOffScreenLabel()
    }
    
    func updateOffScreenLabel() {
        let screenWidth = view.frame.width
        nextQuestionLabelCenterXConstraint.constant = -screenWidth
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
        // 완료되는 시점에 무언가 하고싶다면, completion인자에 클로저를 전달한다.
        /*
        UIView.animate(withDuration:1.5, animations:  {
            self.currentQuestionLabel.alpha = 0
            self.nextQuestionLabel.alpha = 1
        })
        */
        
//        UIView.animate(withDuration: <#T##TimeInterval#>,
//                       delay: <#T##TimeInterval#>,
//                       usingSpringWithDamping: <#T##CGFloat#>,
//                       initialSpringVelocity: <#T##CGFloat#>,
//                       options: <#T##UIView.AnimationOptions#>,
//                       animations: <#T##() -> Void#>,
//                       completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>
//        )
        
        // 아직 처리하지 않은 레이아웃 변경을 미리 요구한다.
        view.layoutIfNeeded()
        
        let screenWidth = view.frame.width
        self.nextQuestionLabelCenterXConstraint.constant = 0
        self.currentQuestionLabelCenterXConstraint.constant += screenWidth
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       // 애니메이션은 기본적으로 이지-인/이지-아웃을 사용, 옵션에서 변경 할 수 있다.
                       options: [.curveLinear],
                       animations: {
                        self.currentQuestionLabel.alpha = 0
                        self.nextQuestionLabel.alpha = 1
                        // 최근 제약 조건을 기준으로 하위 뷰들을 배치하도록 요구한다.
                        self.view.layoutIfNeeded()
                       },
                       completion: { _ in
                        swap(&self.currentQuestionLabel,
                             &self.nextQuestionLabel)
                        swap(&self.currentQuestionLabelCenterXConstraint,
                             &self.nextQuestionLabelCenterXConstraint)
                        
                        self.updateOffScreenLabel()
                       }
        )
    }
    
    
    
//    @IBOutlet var questionLabel: UILabel!
    // 한 라벨이 두 UILbael을 가리키고 있는데, 어떤식으로 작동하는지?
    @IBOutlet var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var currentQuestionLabel: UILabel!
    @IBOutlet var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
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

