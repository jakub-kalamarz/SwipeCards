//
//  CardStackView.swift
//  SwipeCards
//
//  Created by Jakub Kalamarz on 16/06/2021.
//

import UIKit

class CardStackView: UIViewController {
    let viewModel: CardStackViewModel

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    // MARK: Init

    init(viewModel: CardStackViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: UI Setup

extension CardStackView {
    private func setupUI() {
        for i in 0...2 {
            let card = CardView(CardViewModel(position: i))
            card.translatesAutoresizingMaskIntoConstraints = false
            viewModel.cards.append(card)
            card.delegate = self
            view.insertSubview(card, at: 0)

            NSLayoutConstraint.activate([
                card.widthAnchor.constraint(equalTo: view.widthAnchor),
                card.heightAnchor.constraint(equalTo: view.heightAnchor),
                card.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                card.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
        }
    }
}

extension CardStackView:SwipeCardsDelegate {
    func swipeDidEnd(on view: CardView) {
        view.removeFromSuperview()
        viewModel.cards.removeFirst()
        viewModel.cards.forEach {
            $0.viewModel.position -= 1
            $0.animatePosition()
        }
    }
}


