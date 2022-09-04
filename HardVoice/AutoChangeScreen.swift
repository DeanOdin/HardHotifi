//
//  AutoChangeScreen.swift
//  HardVoice
//
//  Created by Дин Кандратенков on 03.09.2022.
//

import UIKit

class AutoChangeScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.performSegue(withIdentifier: "goToMainScreen", sender: self)
        }
    }

}
