//
//  ContentView.swift
//  ScrollViewReaderTest
//
//  Created by Yusuke Hasegawa on 2020/11/20.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var viewModel: ViewModel = .init()
    
    @State var text: String = ""
    @State var value: ScrollViewProxy?

    var body: some View {
        VStack {
            Spacer()
            
            ScrollView {
                ScrollViewReader { value in
                    LazyVStack(alignment: .center, spacing: 16) {
                        ForEach.init(self.viewModel.messages, id: \.id) { message in
                            ChatView.init(message: message)
                        }
                    }.onAppear {
                        self.value = value
                    }
                }
            }
            
            //text input
            VStack {
                HStack {
                    TextEditor.init(text: self.$text)
                        .frame(height:40)
                    Button.init(action: { self.viewModel.send(text: self.text) }, label: {
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 24))
                    }).disabled(self.text.isEmpty)

                }.padding(8)
            }.background(Color(white: 0.95))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
