//
//  MyProvider.swift
//  Widget
//
//  Created by Yuta Okuma on 2020/10/28.
//

import Foundation

class MyProvider {
    
    //this function will get one random string
    static func getRandomString() -> String {
        let strings = [
            "one",
            "two",
            "three",
            "four",
            "five",
            "six",
            "seven",
            "eight",
            "nine",
            "ten",
        ]
        return strings.randomElement()!
    }
    
}
