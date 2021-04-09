//
//  LaunchScreenController.swift
//  WorldTrotterCode
//
//  Created by NHN on 2021/04/08.
//

import Foundation
import UIKit

//launch screen은 ui이므로, 따로 로직이 없다. (런치스크린 스토리보드)
// 화면이 뜨기 전 확인해야 할 것이 있다면 ? -> UI와 별개로, 런치 스크린과 같은 화면을 만들어서, 추가적인 로직은 그곳에서 진행한다.

// 화면 크기, 비율이 달라짐에 따라 그 정보를 런치스크린이 추가적으로 가지고있다.(하위호환성)
class LaunchScreenController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}
