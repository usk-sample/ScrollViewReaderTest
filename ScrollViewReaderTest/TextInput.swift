//
//  TextInput.swift
//  ScrollViewReaderTest
//
//  Created by Yusuke Hasegawa on 2020/11/20.
//

import SwiftUI

struct TextInput: View {
    
    @State var text: String = ""
    
    var body: some View {
        VStack {
            HStack {
                TextEditor.init(text: self.$text)
                    .frame(height:40)
                Button.init(action: {}, label: {
                    Image(systemName: "paperplane.fill")
                        .font(.system(size: 24))
                })

            }.padding(8)
        }.background(Color(white: 0.95))
    }
}

struct TextInput_Previews: PreviewProvider {
    static var previews: some View {
        TextInput()
            .previewLayout(.fixed(width: 320, height: 60))
    }
}
