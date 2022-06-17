//
//  Extensions.swift
//  Slot Machine
//
//  Created by Tin Tran on 17/06/2022.
//

import Foundation
import SwiftUI

extension Text {
    func scoreLabelStyle() -> Text {
        self
            .foregroundColor(.white)
            .font(.system(size: 10, weight: .bold, design: .rounded))
    }
    func scoreNumberStyle() -> Text {
        self.foregroundColor(.white)
            .font(.system(.title, design: .rounded))
            .fontWeight(.heavy)
    }
}
