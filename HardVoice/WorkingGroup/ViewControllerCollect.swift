//
//  ViewControllerNew2.swift
//  HardVoice
//
//  Created by Дин Кандратенков on 28.01.2023.
//

import UIKit

class ViewControllerCollect: UIViewController {
    
    @IBOutlet var CollectionViewIB: UICollectionView!
    
    
    var currentcellIndex = 0
    var currentTextIndex = 0
    
    var helpImages = ["1","2","3","4","5","6"]
    var helpText = ["Инструкция 1","Инструкция 2","Инструкция 3","Инструкция 4","Инструкция 5","Инструкция 6",]
    
    //var timer:Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)*/
    }
    
    @objc func slideToNext()
    {
        if currentcellIndex < helpImages.count - 1
        {
            currentcellIndex = currentcellIndex + 1
            currentTextIndex = currentTextIndex + 1
        }
        else
        {
            currentcellIndex = 0
            currentTextIndex = 0
        }
        
        
        CollectionViewIB.scrollToItem(at: IndexPath(item: currentcellIndex, section: 0), at: .right, animated: true)
    }
    
    
    
}

extension ViewControllerCollect: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return helpImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CollectionViewIB.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        cell.myImage.image = UIImage (named: helpImages[indexPath.row])
        cell.myLabel.text = helpText[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CollectionViewIB.frame.width, height: CollectionViewIB.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
}
