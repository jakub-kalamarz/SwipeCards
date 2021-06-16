//
//  CardStackViewModel.swift
//  SwipeCards
//
//  Created by Jakub Kalamarz on 16/06/2021.
//

import Foundation

class CardStackViewModel {

    var data:[String]

    init() {
        self.data = ApiService.request()
    }

}
