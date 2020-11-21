//
//  ChatView.swift
//  ScrollViewReaderTest
//
//  Created by Yusuke Hasegawa on 2020/11/20.
//

import SwiftUI

struct ChatView: View {
    
    var message: MessageModel
    
    var body: some View {
        HStack {
            if self.message.type == .sent {
                Spacer()
            }
            Text(message.message)
                .padding()
                .background(self.message.type == .sent ? Color.blue : Color.green)
                .cornerRadius(8.0)

            if self.message.type == .received {
                Spacer()
            }
            
        }
        .padding(.vertical, 8)
        .padding(.leading, self.message.type == .received ? 16 : 64)
        .padding(.trailing, self.message.type == .received ? 64 : 16)
  

    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(message: .init(id: 0, message: "Hello!", type: .sent))
    }
}
