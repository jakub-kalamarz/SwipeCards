//
//  CardView.swift
//  SwipeCards
//
//  Created by Jakub Kalamarz on 24/06/2021.
//

import UIKit

class CardView: UIView {
    // MARK: Properties

    let viewModel: CardViewModel

    var swipeView: UIView!

    var label = UILabel()

    var delegate: SwipeCardsDelegate?

    var inset: CGFloat = 10
    var baseConstraint = [NSLayoutConstraint]()
    var labelConstraint = [NSLayoutConstraint]()

    // MARK: Init

    init(_ viewModel: CardViewModel ) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        configureSwipeView()
        configureLabelView()
        addPanGestureOnCards()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Configuration

    func configureSwipeView() {
        swipeView = UIView()
        swipeView.backgroundColor = .white
        swipeView.layer.cornerRadius = 15
        swipeView.layer.shadowColor = UIColor.black.cgColor
        swipeView.layer.shadowOpacity = 1
        swipeView.layer.shadowOffset = .zero
        swipeView.layer.shadowRadius = 10
        swipeView.clipsToBounds = true
        addSubview(swipeView)

        swipeView.translatesAutoresizingMaskIntoConstraints = false

        baseConstraint = [
            swipeView.widthAnchor.constraint(equalToConstant: CGFloat(260 - viewModel.position * 13) ),
            swipeView.heightAnchor.constraint(equalToConstant: CGFloat(400 - viewModel.position * 20)),
            swipeView.centerXAnchor.constraint(equalTo: centerXAnchor),
            swipeView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: CGFloat(viewModel.position * 20)),
        ]

        baseConstraint.forEach { $0.isActive = true}
    }

    func configureLabelView() {
        swipeView.addSubview(label)
        label.backgroundColor = .white
        label.textColor = .black
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Card \(viewModel.position)"

        labelConstraint = [
            label.centerYAnchor.constraint(equalTo: centerYAnchor, constant: CGFloat(viewModel.position * 20)),
            label.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]

        NSLayoutConstraint.activate(labelConstraint)
    }

    func animatePosition() {

        NSLayoutConstraint.deactivate(baseConstraint)
        baseConstraint = [
            swipeView.widthAnchor.constraint(equalToConstant: CGFloat(260 - viewModel.position * 13) ),
            swipeView.heightAnchor.constraint(equalToConstant: CGFloat(400 - viewModel.position * 20)),
            swipeView.centerXAnchor.constraint(equalTo: centerXAnchor),
            swipeView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: CGFloat(viewModel.position * 20)),
        ]
        NSLayoutConstraint.deactivate(labelConstraint)
        labelConstraint = [
            label.centerYAnchor.constraint(equalTo: centerYAnchor, constant: CGFloat(viewModel.position * 20)),
            label.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]
        NSLayoutConstraint.activate(baseConstraint)
        NSLayoutConstraint.activate(labelConstraint)
        
    UIView.animate(withDuration: 1) { [self] in
        layoutIfNeeded()
    }
    }

    func addPanGestureOnCards() {
        isUserInteractionEnabled = true
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture)))
    }

    // MARK: Handlers

    @objc func handlePanGesture(sender: UIPanGestureRecognizer) {
        let card = sender.view as! CardView
        let point = sender.translation(in: self)
        let centerOfParentContainer = CGPoint(x: frame.width / 2, y: frame.height / 2)
        card.center = CGPoint(x: centerOfParentContainer.x + point.x, y: centerOfParentContainer.y + point.y)

        switch sender.state {
        case .ended:
            if card.center.x > 400 {
                delegate?.swipeDidEnd(on: card)
                UIView.animate(withDuration: 0.2) {
                    card.center = CGPoint(x: centerOfParentContainer.x + point.x + 200, y: centerOfParentContainer.y + point.y + 75)
                    card.alpha = 0
                    self.layoutIfNeeded()
                }
                return
            } else if card.center.x < -65 {
                delegate?.swipeDidEnd(on: card)
                UIView.animate(withDuration: 0.2) {
                    card.center = CGPoint(x: centerOfParentContainer.x + point.x - 200, y: centerOfParentContainer.y + point.y + 75)
                    card.alpha = 0
                    self.layoutIfNeeded()
                }
                return
            }
            UIView.animate(withDuration: 0.2) {
                card.transform = .identity
                card.center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
                self.layoutIfNeeded()
            }
        case .changed:
            let rotation = tan(point.x / (frame.width * 2.0))
            card.transform = CGAffineTransform(rotationAngle: rotation)

        default:
            break
        }
    }
}
