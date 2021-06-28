//
//  CardProtocol.swift
//  SwipeCards
//
//  Created by Jakub Kalamarz on 24/06/2021.
//

import Foundation
import UIKit

protocol SwipeCardsDataSource {
    func numberOfCardsToShow() -> Int
    func card(at index: Int) -> CardView
    func emptyView() -> UIView?
}

protocol SwipeCardsDelegate {
    func swipeDidEnd(on view: CardView)
}
