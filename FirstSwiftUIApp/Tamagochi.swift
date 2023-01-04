//
//  Tamagochi.swift
//  FirstSwiftUIApp
//
//  Created by 최형민 on 2023/01/04.
//

import SwiftUI

// Opaque Type (역제네릭)
// 컴파일 시 실제 값에 반환을 해줌
// 프로퍼티 내부에서는 실제 타입이 어떤지 명확하게 알 수 있음

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

struct Tamagochi: View {
    
    @State var riceCount: Int = 0
    @State var waterCount: Int = 0
    
    var body: some View { // 뷰 렌더링
        VStack(spacing: 10) {
            Text("방실방실 다마고치")
            Text("Lv 1. 밥알 \(riceCount)개 물방울 \(waterCount)개")
            GrowButton(text: "밥 먹기", icon: Image(systemName: "star")) {
                riceCount += 1
            }
            GrowButton(text: "물 먹기", icon: Image(systemName: "pencil")) {
                waterCount += 1
            }
        }
    }
}

struct Tamagochi_Previews: PreviewProvider {
    static var previews: some View {
        Tamagochi()
    }
}
