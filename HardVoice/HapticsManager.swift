//
//  HapticsManager.swift
//  HardVoice
//
//  Created by Дин Кандратенков on 25.09.2022.
//
import UIKit

class HapticsManager {
    static let instanse = HapticsManager()
 
    func notification(type:UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style:UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
    
    
}
     
