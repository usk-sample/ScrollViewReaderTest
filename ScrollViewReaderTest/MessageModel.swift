//
//  MessageModel.swift
//  ScrollViewReaderTest
//
//  Created by Yusuke Hasegawa on 2020/11/20.
//

import Foundation

struct MessageModel {
    let id: Int
    let message: String
    let type: MessageType
}

extension MessageModel: Equatable {
    static func == (lhs: MessageModel, rhs: MessageModel) -> Bool {
        return lhs.id == rhs.id
    }
}

enum MessageType {
    case sent
    case received
}
