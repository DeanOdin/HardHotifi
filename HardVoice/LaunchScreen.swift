//
//  AutChangeScreen.swift
//  HardVoice
//
//  Created by Дин Кандратенков on 03.09.2022.
//

import UIKit

class LaunchScreen: UIViewController {
    
    var imageView: UIImageView = {
        
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        imageview.image = UIImage(named: "preview")
        return imageview
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            self.performSegue(withIdentifier: "goToMainScreen", sender: self)
//        }
        
        imageView.frame = CGRect.zero
        imageView.center = view.center
        
        view.addSubview(imageView)
        
        UIView.animate(withDuration: 1.0, animations: {
            self.imageView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 300, height: 300))
            self.imageView.center = self.view.center
        }, completion: {_ in
            self.performSegue(withIdentifier: "goToMainScreen", sender: self)
        })
        //animate(withDuration: 1.0) {
//            self.imageView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 300, height: 300))
//            self.imageView.center = self.view.center
//        }
        
    }
 

}
