# SwiftUI

**알아야 될 내용 (면접에서는 지금 학습 중인 단계라고 강조)**

1. SwiftUI 구조
2. 뷰 구조 - **Opaque Type(역 제네릭)**
3. 데이터 흐름 propertyWrapper
    - @state, @binding, @environment, @published
4. 라이프 사이클

원래는 UIKit(아이폰), AppKit(맥), WatchKit(애플워치)을 따로 개발해야 했음

- SwiftUI가 이 모든 걸 통합시킴

```swift
import SwiftUI

@main
struct FirstSwiftUIAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

- 이 코드는 AppDelegate, SceneDelegate라고 생각하면 됨
- App이라는 프로토콜 기반, 원래는 ViewController 같은 것은 클래스 기반
    - SwiftUI는 대부분 **프로토콜, 구조체** 기반
    - 확장이 자유롭지 않다
    - associatedtype: 프로토콜에서 사용하는 제네릭 타입

AppDelegate(실행 종료 담당)에서 SceneDelegate 생긴 이유 → 아이패드 OS 등장 

- 큰 화면에 여러 화면 쪼개서 분할하기 위해 (같은 앱도 띄울 수 있음)
    - WindowGroup 객체가 이를 도와줌

AddSubView, Layout이 필요없어짐

- UI가 선언형으로 만들어짐

**제네릭 타입의 특성**

![스크린샷 2023-01-04 오전 10 47 57](https://user-images.githubusercontent.com/70970222/210508916-11588fe9-3aa7-4d50-a8f1-1f73cb01b4d9.png)

```swift
import SwiftUI

struct Tamagochi: View {

        // body는 연산 프로퍼티(타입 명시 필요), get 키워드가 생략되어 있는 형태 
    var body: some View {
        Text("Hello, World!")
    }
}
```

- body는 연산 프로퍼티(타입 명시 필요), get 키워드가 생략되어 있는 형태
    - 해당 Text를 리턴하는 형태
    - 연산 프로퍼티 - 값 하나만 리턴함
        - 그래서 계속 stack, group으로 묶어야함
- 타입이 some View인 이유
    - 원래는 버튼 사용하면 버튼 타입, VStack/HStack 사용하면 다 명시해줘야함
    - some View 프로토콜로 채택하면 다 생략가능
    - **프로퍼티 내부에서는 실제 타입이 어떠건지 명확히 알 수 있음**
    - **프로퍼티 외부에서는 어떤 타입인지 알 수 없음**
        - **역 제네릭! (Opaque Type) - 이렇게 코드를 짜야 편하니까**
        - 컴파일 할 때는 실제 값에 반환을 해줌
    - 스위프트 5.1 some, propertyWrapper 키워드 등장

```swift
struct Tamagochi: View {
    var body: some View {
        VStack {
            Text("방실방실 다마고치")
            Text("Lv 1. 밥알 3개 물방울 15개")
            Button {
                print("버튼을 클릭했습니다")
            } label: {
                Text("밥 먹기")
            }
                        .padding()
            Button("밥 먹기") {
                print("버튼을 클릭했습니다")
            }
        }
    }
}
```

- 같은 버튼이지만 아래 버튼은 텍스트밖에 못 넣음
    - 아이콘 넣고 싶으면 label 파라미터를 활용해야함
- 컴포넌트들 사이를 띄워놓기
    - ex. padding, vStack(spacing:10) 등 여러 방법 있음

![스크린샷 2023-01-04 오전 11 11 11](https://user-images.githubusercontent.com/70970222/210508912-ff513da7-d0e3-4cb1-b3bf-821da5bba3a7.png)

- Component의 modifier들임 (ex. padding, background)
    - 순서 굉장히 중요, 순서에 따라 결과가 다를 수 있음
        - ex. padding 맨 뒤로 오면 foreground에 영향 줌

- 재사용하는 component들을 구조체로 정의해두면 코드 구조가 굉장히 간편해짐
    - 인스턴스 마다 다른 것들은 구조체의 프로퍼티로 빼서 선언할 때마다 정의해주면 됨

- 구조체(Struct) 내에서 프로퍼티의 값 변경 불가 (클래스와의 차이)
    - mutating 키워드를 연산 프로퍼티에 사용하면 가능
        - **copy on write**
            - 값이 같으면 메모리값을 공유 (메모리 절약 가능)
            - 구조체에서 값이 바뀌면 새로운 메모리에 지정해줘야 하기 때문에 변경 불가
    - 값을 바꾸게 되면 메모리 공간을 계속 생성하게 되는데, 구조체는 메모리를 공유함
    
    ![스크린샷 2023-01-04 오전 11 45 06](https://user-images.githubusercontent.com/70970222/210508910-f06f9a3e-d2c2-40b0-90fd-561ba8ab50a8.png)
    
    ![스크린샷 2023-01-04 오전 11 55 28](https://user-images.githubusercontent.com/70970222/210508906-ec6419f0-0115-436e-90fe-9d37252c67f6.png)
    
    - 구조체에 바꾸고 싶은 프로퍼티 앞에 **@State(propertyWrapper)** 추가
    - View가 바뀔 때 마다 화면을 계속 새로 그려줌
        - property가 바뀔 때 마다 계속 그리는 로직
