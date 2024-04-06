//
//  CardView.swift
//  iosApp
//
//  Created by Alexia Aldea on 06.04.2024.
//

import Foundation
import SwiftUI

struct CardView: View {
    @Binding var showDetails: Bool
    let card: Card
    private var cardSize: CGSize {
        let scaleFactor: CGFloat = 2
        let width = UIScreen.main.bounds.width / scaleFactor
        let aspectRatio = 1.5
        let height = width * aspectRatio
        return .init(width: width, height: height)
    }
    var body: some View {
        Image(!showDetails ? card.thumbnailUrl : card.detailsIcon)
            .resizable()
            .frame(width: cardSize.width, height: cardSize.height)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct CardsCarouselView: View {
    @Binding var showDetails: Bool
    var cards: [Card]
    @Binding var selectedCard: Card
    @State private var offset: CGFloat = .zero
    private let cardOffset: CGFloat = 65
    
    var body: some View {
        ZStack {
            ForEach(self.cards, id: \.id) { card in
                CardView(showDetails: $showDetails,
                         card: card)
                    .overlay {
                        (selectedCard != card ?
                         Color.white
                         :
                            Color.clear)
                        .opacity(0.2)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                    .blur(radius: selectedCard == card ? 0 : 2)
                    .scaleEffect(selectedCard == card ? 1 : 0.9)
                    .offset(x: CGFloat(getOffsetOf(card: card)))
                    .offset(x: self.offset * CGFloat(selectedCard == card ? 1 : 0))
                    .zIndex(getZIndexOf(card: card))
                    .gesture(
                        DragGesture()
                            .onChanged({ drag in
                                self.offset = drag.translation.width
                            })
                            .onEnded({ drag in
                                withAnimation(.default) {
                                    self.offset = .zero
                                    if drag.translation.width > 0 {
                                        handleSwipeToRight()
                                    } else {
                                        handleSwipeToLeft()
                                    }
                                }
                            })
                    )
                    .onTapGesture {
                        handleOnTap(card: card)
                    }
                    .animation(.smooth, value: selectedCard)
            }
        }
    }
    
    private func handleSwipeToRight() {
        let selectedCardIndex = cards.firstIndex(of: selectedCard) ?? 0
        if selectedCardIndex > 0 {
            selectedCard = cards[selectedCardIndex - 1]
        }
    }
    
    private func handleSwipeToLeft() {
        let selectedCardIndex = cards.firstIndex(of: selectedCard) ?? 0
        if selectedCardIndex < cards.count - 1 {
            selectedCard = cards[selectedCardIndex + 1]
        }
    }
    
    private func handleOnTap(card: Card) {
        let offset = getOffsetOf(card: card)
        withAnimation(.default) {
            switch offset {
            case -cardOffset:
                self.offset = cardOffset
                handleSwipeToRight()
            case cardOffset:
                self.offset = -cardOffset
                handleSwipeToLeft()
            default: break
            }
            self.offset = .zero
        }
    }
    
    private func getOffsetOf(card: Card) -> CGFloat {
        let cardIndex = self.cards.firstIndex { $0.id == card.id}
        let selectedCardIndex = self.cards.firstIndex { $0.id == selectedCard.id } ?? 0
        switch cardIndex {
        case selectedCardIndex:
            return 0
        case selectedCardIndex - 1:
            return -cardOffset
        case selectedCardIndex + 1:
            return cardOffset
        default: return 0
        }
    }
    
    private func getZIndexOf(card: Card) -> CGFloat {
        let cardIndex = self.cards.firstIndex { $0.id == card.id}
        let selectedCardIndex = self.cards.firstIndex { $0.id == selectedCard.id } ?? 0
        switch cardIndex {
        case selectedCardIndex:
            return 3
        case selectedCardIndex - 1:
            return 2
        case selectedCardIndex + 1:
            return 2
        default: return 1
        }
    }
}
