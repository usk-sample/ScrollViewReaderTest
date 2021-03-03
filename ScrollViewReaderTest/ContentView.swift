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
    
    var observer: ScrollViewObserver = .init()
    
    @State var canLoadPrevious: Bool = false
    @State var text: String = ""
    @State var value: ScrollViewProxy?
    
    var body: some View {
        VStack {
            
            ScrollView {
                
                ScrollViewReader { value in

                    LazyVStack(alignment: .center, spacing: 16) {
                        
                        ForEach.init(self.viewModel.messages, id: \.id) { message in
                            ChatView.init(message: message, isTop: self.viewModel.messages.firstIndex(of: message) == 0)
                        }
                    }.onAppear {
                        self.value = value
                        self.value?.scrollTo(self.viewModel.messages.count, anchor: .bottom) // scroll to bottom at first
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            self.canLoadPrevious = true
                        }
                    }.animation(.easeInOut)
                }
            }.introspectScrollView { scrollView in
                scrollView.bounces = false
                scrollView.delegate = observer
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

class ScrollViewObserver: NSObject, UIScrollViewDelegate {
    
    //一番上に到達した時、
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        debugPrint(scrollView.contentOffset)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
