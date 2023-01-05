//
//  Tamagochi.swift
//  FirstSwiftUIApp
//
//  Created by 최형민 on 2023/01/04.
//

import SwiftUI

// Opaque Type <-> Generic Type (역제네릭)
// 컴파일 시 실제 값에 반환을 해줌
// 프로퍼티 내부에서는 실제 타입이 어떤지 명확하게 알 수 있음
// 프로퍼티 외부에서는 어떤 타입인 지 알 수 없음
// Generic Type은 반대

// some -> 컴파일 시 실제 값을 찾아서 반환

/*
 1. 구조체
 2. 연산 프로퍼티 -> 항상 body가 그려질 때 전부 다시 그려짐
 -> 그려지는 패턴이 다름
 
 재사용을 다른 뷰에서 하지 않으면 그냥 뷰 구조체 안에서 연산 프로퍼티로 선언해도 됨
 */

/*
 V H Z Stack: 전체 데이터를 메모리에 담아두고 스크롤 할 때 보여줄 뿐
 LazyVStack LazyHStack: 화면에 랜더링 될 때 데이터를 메모리에 담고 그림
 - paging(화면 다시 그릴 필요가 있을 때)일 때 사용
 - 필요할 때 랜더링 다시 해줌
 - Lazy -> 미리 준비 안 하겠다는 의미
 */

struct GrowButton: View {
    var text: String
    var icon: Image
    var action: (() -> Void)
    
    var body: some View {
        
        Button(action: action, label: {
            icon
            Text(text)
        })
        .padding()
        .background(.black)
        .foregroundColor(.white)
        .cornerRadius(20)
    }
}

//struct ComputedProperty: View {
//    
//    var apple = "사과"
//    
//    var body: some View {
//        Text(apple)
//    }
//}

struct ExampleText: View {
    var body: some View {
        Text("방실방실 다마고치 \(Int.random(in: 1...100))")
    }
}
struct Tamagochi: View {
    
    // @state: 다른 뷰와 공유 불가능, 그래서 일반적으로 private 키워드 추가
    @State private var riceCount: Int = 0
    @State private var waterCount: Int = 0
    @State private var showModal = false
    
    // 연산 프로퍼티로 뷰의 컴포넌트를 나누는 방법
    var characterName: some View {
        Text("방실방실 다마고치 \(Int.random(in: 1...100))")
    }
    
    var body: some View { // 뷰 렌더링
        VStack(spacing: 10) {
            // characterName과 다르게 ExampleText()는 새로 랜더링 되지 않음
            // 연산 프로퍼티만 다시 그림
            characterName
            ExampleText()
            Text("Lv 1. 밥알 \(riceCount)개 물방울 \(waterCount)개")
            GrowButton(text: "밥 먹기", icon: Image(systemName: "star")) {
                riceCount += 1
            }
            GrowButton(text: "물 먹기", icon: Image(systemName: "pencil")) {
                waterCount += 1
            }
            GrowButton(text: "통계 보기", icon: Image(systemName: "pencil")) {
                showModal = true
            }
            .sheet(isPresented: $showModal) {
                ExampleView()
            }
        }
        // viewDidLoad가 사라짐
        .onAppear(perform: {
            print("viewDidAppear")
            print("viewDidLoad에서 하고 싶은 일을 여기 쓰면 이상해짐..")
        })
        .onDisappear {
            print("viewDidDisppear")
        }
    }
}

struct Tamagochi_Previews: PreviewProvider {
    static var previews: some View {
        Tamagochi()
    }
}
