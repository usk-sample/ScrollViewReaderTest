//
//  ContentView.swift
//  ScrollViewReaderTest
//
//  Created by Yusuke Hasegawa on 2020/11/20.
//

import SwiftUI
import Introspect

struct ContentView: View {
    
    @ObservedObject private var viewModel: ViewModel = .init()
        
    @State var canLoadPrevious: Bool = false
    @State var text: String = ""
    @State var value: ScrollViewProxy?
    
    var body: some View {
        VStack {
            
            ScrollView {
                
                ScrollViewReader { value in

                    LazyVStack(alignment: .center, spacing: 16) {
                        
                        ForEach.init(self.viewModel.messages, id: \.id) { message in
                            ChatView.init(message: message, isTop: self.viewModel.messages.firstIndex(of: message) == 0) {
                                guard canLoadPrevious else { return }
                                debugPrint("onAppear top")
                                                                
                                let firstId = viewModel.messages.first!.id
                                debugPrint("first : \(firstId)")
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    self.viewModel.loadPrevious()
                                    DispatchQueue.main.async {
                                        self.value?.scrollTo(firstId, anchor: .top)
                                    }
                                }
                            }
                        }
                    }.onAppear {
                        debugPrint("[LazyVStack]onAppear")
                        self.value = value
                        if let last = self.viewModel.messages.last {
                            self.value?.scrollTo(last.id, anchor: .bottom) // scroll to bottom at first
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            self.canLoadPrevious = true
                        }
                    }.animation(.none)
                }
            }.introspectScrollView { scrollView in
                scrollView.bounces = false
            }
            
            //text input
            VStack {
                HStack {
                    TextEditor.init(text: self.$text)
                        .frame(height:40)
                        .cornerRadius(4.0)
                    Button.init(action: { self.sendText() }, label: {
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 24))
                    }).disabled(self.text.isEmpty)

                }.padding(8)
            }.background(Color(white: 0.95))
        }
    }
}

extension ContentView {
    
    func sendText() {
        viewModel.send(text: text)
        text = ""
        guard let message = viewModel.messages.last else { return }
        debugPrint(message)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            withAnimation {
                self.value?.scrollTo(message.id, anchor: .bottom)
            }

        })
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
