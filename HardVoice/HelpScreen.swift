//
//  HelpScreen.swift
//  HardVoice
//
//  Created by Дин Кандратенков on 10.09.2022.
//

import SwiftUI
import UIKit

struct HelpScreen: View {
    
    private var numberOfImage = 5
    
    // Подтягиваю скрины с подсказками
    var body: some View {
        
        GeometryReader { proxy in
            TabView{
                
            ForEach(1..<numberOfImage) { num    in
                Image ("\(num)")
                    .resizable()
                    .scaledToFill()
                   // .overlay(Color.black.opacity(0.4))
                    .tag(num)
                }

            }.tabViewStyle(PageTabViewStyle())
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .padding()
            .frame(width: proxy.size.width, height: proxy.size.height / 3)
            
            VStack(alignment: .leading ){
                
                    Text("Шаг 1")
                    .offset(y: 250)
                    .padding()
                    .offset(x: 10)
                    .font(.title)
                    
                    
                HStack {
                    Text("Скипай пальцем картинку")
                    .padding()
                }
            }
        }
        
        
    }

    
}
    


class HelpScreenController: UIHostingController<HelpScreen> {

    required init?(coder: NSCoder) {
        super.init(coder: coder,rootView: HelpScreen());
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    struct HelpScreen_Previews: PreviewProvider {
        static var previews: some View {
            HelpScreen()
        }
    }
}




