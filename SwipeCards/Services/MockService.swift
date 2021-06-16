//
//  MockService.swift
//  SwipeCards
//
//  Created by Jakub Kalamarz on 16/06/2021.
//

import Foundation

final class ApiService {
    static func request() -> [String] {
        var data = [String]()
        for i in 1...5 {
            data.append("Card \(i)")
        }
        return data
    }
}
