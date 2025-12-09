//
//  Item.swift
//  typodot
//
//  Created by koukibuu3 on 2025/12/09.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
