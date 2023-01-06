//
//  InputView.swift
//  FirstSwiftUIApp
//
//  Created by 최형민 on 2023/01/05.
//

import SwiftUI

/*
 Storyboard(UIKit) + SwiftUI > UIHostingController
 SwiftUI + Storyboard(UIKit) > UIViewRepresentable / UIViewControllerRepresentable
 */

struct UserTextView: View {
    
    // @Binding → @State로 선언된 프로퍼티를 뷰 외부에서 사용하고 싶을 때
    // UserTextView에서도 변경된 프로퍼티 값을 적용하고 싶을 때 binding 프로퍼티 선언해서 바뀐 값을 전달 받음
    @Binding var text: String
    
    var body: some View {
        Text("안녕하세요")
    }
}

struct ChatTextView: UIViewRepresentable {
    
    @Binding var text: String
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.backgroundColor = .lightGray
        return textView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.text = text
    }
}

struct InputView: View {
    
    @State private var nickname = ""
    
    var body: some View {
        // $로 값 변경 감지
        VStack {
            TextField("닉네임을 입력해주세요", text: $nickname, axis: .vertical)
                .padding()
                .lineLimit(4)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            // UserTextView(text: $nickname)
            ChatTextView(text: $nickname)
        }
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView()
    }
}
