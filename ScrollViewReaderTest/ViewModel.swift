//
//  ViewModel.swift
//  ScrollViewReaderTest
//
//  Created by Yusuke Hasegawa on 2020/11/20.
//

import Foundation

class ViewModel: ObservableObject {
    
    @Published var messages: [MessageModel] = []
    
    init() {
        
        messages.append(.init(id: 1, message: "Hello!", type: .received))
        messages.append(.init(id: 2, message: "Hello, how are you?", type: .sent))
        messages.append(.init(id: 3, message: "Good!", type: .received))
        messages.append(.init(id: 4, message: "Good!!", type: .sent))
        
    }
    
}

extension ViewModel {
    
    func send(text: String) {
        debugPrint("text : \(text)")
    }
    
}
