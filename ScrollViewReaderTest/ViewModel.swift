//
//  ViewModel.swift
//  ScrollViewReaderTest
//
//  Created by Yusuke Hasegawa on 2020/11/20.
//

import Foundation

enum MessageItem {
    case loadPrevious
    case message(MessageModel)
}

extension MessageItem: Identifiable {
    var id: Int {
        switch self {
        case .loadPrevious: return -1
        case .message(let message): return message.id
        }
    }

}

class ViewModel: ObservableObject {
    
    @Published var items: [MessageItem] = []
    @Published var messages: [MessageModel] = []
    
    init() {
        
        messages.append(.init(id: 1, message: "Hello!", type: .received))
        messages.append(.init(id: 2, message: "Hello, how are you?", type: .sent))
        messages.append(.init(id: 3, message: "Good!", type: .received))
        messages.append(.init(id: 4, message: "Good!!", type: .sent))
        messages.append(.init(id: 5, message: "Good!", type: .received))
        messages.append(.init(id: 6, message: "Good!!", type: .sent))
        messages.append(.init(id: 7, message: "Good!", type: .received))
        messages.append(.init(id: 8, message: "Good!!", type: .sent))
        messages.append(.init(id: 9, message: "Good!", type: .received))
        messages.append(.init(id: 10, message: "Good!!", type: .sent))
        messages.append(.init(id: 11, message: "Good!!", type: .sent))
        messages.append(.init(id: 12, message: "Good!!", type: .sent))
        messages.append(.init(id: 13, message: "Good!!\nGood!!", type: .sent))
        
        items.append(.loadPrevious)
        items.append(contentsOf: messages.map({ MessageItem.message($0)}))
        
    }
    
}

extension ViewModel {
    
    func loadPrevious() {
        
        messages.insert(.init(id: messages.count, message: "Hello!", type: .received), at: 0)
        messages.insert(.init(id: messages.count, message: "Hello!", type: .received), at: 0)
        messages.insert(.init(id: messages.count, message: "Hello!", type: .received), at: 0)
        messages.insert(.init(id: messages.count, message: "Hello!", type: .received), at: 0)
        
        items.insert(.message(.init(id: items.count + 1, message: "Hello!!", type: .received)), at: 0)
        items.insert(.message(.init(id: items.count + 1, message: "Hello!!", type: .sent)), at: 0)
        items.insert(.message(.init(id: items.count + 1, message: "Hello!!", type: .received)), at: 0)
        items.insert(.message(.init(id: items.count + 1, message: "Hello!!", type: .sent)), at: 0)
        items.insert(.message(.init(id: items.count + 1, message: "Hello!!", type: .received)), at: 0)
        items.insert(.message(.init(id: items.count + 1, message: "Hello!!", type: .sent)), at: 0)
        items.insert(.message(.init(id: items.count + 1, message: "Hello!!", type: .received)), at: 0)

    }
    
    
    func send(text: String) {
        debugPrint("text : \(text)")
        debugPrint("count : \(messages.count)")
        
        messages.append(.init(id: messages.count + 1, message: text, type: .sent))
        items.append(.message(.init(id: messages.count + 1, message: text, type: .sent)))
    }
    
}
