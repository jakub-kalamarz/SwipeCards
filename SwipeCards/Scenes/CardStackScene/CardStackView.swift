//
//  CardStackView.swift
//  SwipeCards
//
//  Created by Jakub Kalamarz on 16/06/2021.
//

import UIKit

class CardStackView: UIViewController {

    let viewModel:CardStackViewModel

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //MARK::Init
    init(viewModel:CardStackViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
