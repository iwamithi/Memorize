//
//  ContentView.swift
//  Memorize
//
//  Created by ian papa on 19/09/2023.
//

import SwiftUI

struct ContentView: View {
    let emojis: Array<String> = ["👻","🎃","😈","🧟‍♀️","🚘","🚜","🚀","🚡","🍌","✈️"]
    
    @State var cardCount: Int = 4
    var body: some View {
        VStack{
            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjusters
        }
        .padding()
    }
    var cards: some View {
        
        LazyVGrid(columns: [GridItem(.adaptive(minimum:120))]) {
            ForEach(0..<cardCount, id: \.self){ index in CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
        cardCount += offset
    }, label: {
        Image(systemName: symbol)
    })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
}
    
    var cardRemover: some View {
        return cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill" )
    }
    
    var cardAdder: some View {
        return cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill" )
    }

    
    struct CardView: View {
        let content: String
        @State  var isfaceup:Bool = false
        var body: some View{
            ZStack {
                let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
                Group{
                    
                    base.fill(.white)
                    base.strokeBorder(lineWidth: 2)
                    Text(content).font(.largeTitle)

                }
                .opacity(isfaceup ? 1:0)
                base.fill().opacity(isfaceup ? 0: 1)
                
                
                
            }
            .onTapGesture{
                isfaceup.toggle()
            }
        }
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
    
    
}
