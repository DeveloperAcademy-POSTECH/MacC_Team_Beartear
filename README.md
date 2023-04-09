# 티라미술(Tiramisul)

<div align="center">

<img width=200 src="https://user-images.githubusercontent.com/59136391/230754824-4e204132-feb9-4fdc-830b-e1d83217b594.png">

📆 2022. 06. 27. ~ 2022. 08. 01.

[<img src="https://img.shields.io/badge/Swift-5.6-orange?">](https://developer.apple.com/kr/swift/) [<img src="https://img.shields.io/badge/Xcode-13.4.1-blue?">](https://developer.apple.com/kr/xcode/)

[🍎 App Store 🔗](https://apps.apple.com/us/app/티라미술/id6444958855)

[📝 Backlog 🔗](https://pie-parka-8ba.notion.site/0bccc258ec59454589dd8574279aa278)


</div>

## 📱 Screenshots
![Component 2](https://user-images.githubusercontent.com/59136391/230754740-359fd127-ad66-49e0-be32-b306d75c334f.png)



<br>

## 🧑🏻‍💻👩🏻‍💻 Members

|<img src="https://github.com/HoJongE.png">|<img src="https://github.com/SH0123.png">|<img src="https://github.com/rriver2.png">|<img src="https://github.com/imparang.png">|<img src="https://github.com/22Seongsoo.png">|<img src="https://github.com/yungahui.png">|
|:-:|:-:|:-:|:-:|:-:|:-:|
|[HojongE](https://github.com/HoJongE)|[Raymond](https://github.com/SH0123)|[River](https://github.com/rriver2)|[Ekko](https://github.com/imparang)|[Ssoo](https://github.com/22Seongsoo)|[Aesop](https://github.com/yungahu)|

<br>

## 🎯 Project Goal

**미술을 통해 생각을 끌어올리다!**
미술 작품 감상을 통해 사고력을 증진시켜주자.

- 작품이 던지는 질문
작품을 감상하기 전 작품의 주제와 관련된 질문을 받습니다.
질문에 대해 생각하고 답하며 작품에 공감할 수 있도록 도와줍니다.

- 작품 감상
작품 설명과 함께 작품을 감상할 수 있습니다.
마음에 드는 문장에 하이라이트를 하고, 작품을 확대해서 자세하게 감상할 수 있습니다.

- 감상문 작성
작품을 보고 드는 생각이나 느낀점을 작성할 수 있습니다.

- 감상 기록 히스토리
내가 감상한 작품들이 히스토리에 기록됩니다.

- (추가 예정) 서로의 감상평 및 의견 교류
SNS 형태로 서로의 감상평을 공유하고 의견을 나눌 수 있습니다.

<br>

## 🛠 Developement Environment

|Environment|Version|
|:-:|:-:|
|Swift|5.6.1|
|Xcode|14.0.1|
|iOS Deployment Target|15.0|

<br>

## 🐈‍⬛ Git

### 코드 리뷰달 때 달아야 할 거

- 기존 뱅크샐러드 코드 리뷰 문화에서 단순히 p1, p2, p3, p4, p5 식으로 제안을 하는거는 단기간 프로젝트에서 너무 많은 헷갈림을 남길 수 있다는 의견이 나오
- 다음과 같이 3가지로 축약하고, 한글로 적었습니다.
    - 수정필수 -> 수정을 꼭 하고 넘어가야 하는 제안사항입니다.
    - 수정고려 -> 수정을 해도 되고 안 해도 되는 제안사항입니다.
    - 사소한의견 -> 아무런 생각을 하지 않아도 되고 무시해도 되는 사항입니다.

코드 리뷰 예시
```plain
[수정필수]
~~~ 이렇게 바꾸는게 좋아요
```

### 브랜치 작성 규칙

#### Summary

```swift
{태그이름}/{#이슈번호}_{간단한 설명}
```

- 형식으로 작성한다.

#### 태그 목록
| 태그 이름  | 설명 |
| --- | --- |
| Feat | 새로운 기능을 추가 |
| Fix | 버그를 고친 경우 |
| Design | 사용자 UI 디자인 변경 |
| !BREAKING CHANGE | 커다란 API 의 변경 |
| !HOTFIX | 급하게 치명적인 버그를 고쳐야하는 경우 |
| Style | 코드 포맷 변경, 세미 클론 누락 (오타 수정, 탭 사이즈 변경, 변수명 변경) |
| Refactor | 프로덕션 코드 리팩토링 |
| Comment | 필요한 주석 추가 및 변경 |
| Docs | 문서 수정 |
| Test | 테스트 추가, 테스트 리팩토링 (프로덕션 코드 변경 X) |
| Chore | 빌드 테스트 업데이트, 패키지 매니저를 설정 |
| Rename | 파일 혹은 폴더명을 수정하거나 옮기는 작업만인 경우 |
| Remove | 파일을 삭제하는 작업만 수행한 경우 |

#### Reference
[Udacity Commit Convention](https://overcome-the-limits.tistory.com/entry/협업-협업을-위한-기본적인-git-커밋컨벤션-설정하기)

#### Summary

```kotlin
type(옵션):[#issueNumber]Subject //-> 제목
개행
body(옵션):// ->본문
개행
footer(옵션)://-> 꼬리말
```

#### 제목 작성 방법

타입은 **태그**와 **제목**으로 구성되며, **태그**는 영어로 쓰되 첫 문자는 대문자로 한다.

“태그: 제목” 의 형태이며, : 뒤에만 공백이 들어간다.

**태그**

| 태그 이름  | 설명 |
| --- | --- |
| Feat | 새로운 기능을 추가 |
| Fix | 버그를 고친 경우 |
| Design | 사용자 UI 디자인 변경 |
| !BREAKING CHANGE | 커다란 API 의 변경 |
| !HOTFIX | 급하게 치명적인 버그를 고쳐야하는 경우 |
| Style | 코드 포맷 변경, 세미 클론 누락 (오타 수정, 탭 사이즈 변경, 변수명 변경) |
| Refactor | 프로덕션 코드 리팩토링 |
| Comment | 필요한 주석 추가 및 변경 |
| Docs | 문서 수정 |
| Test | 테스트 추가, 테스트 리팩토링 (프로덕션 코드 변경 X) |
| Chore | 빌드 테스트 업데이트, 패키지 매니저를 설정 |
| Rename | 파일 혹은 폴더명을 수정하거나 옮기는 작업만인 경우 |
| Remove | 파일을 삭제하는 작업만 수행한 경우 |

#### 제목의 작성 방법

1. 제목의 처음은 동사 원형으로 시작한다.<br>
2. 총 글자 수는 50자 이내로 작성<br>
3. 마지막에 특수문자는 삽입하지 않는다<br>
4. 제목은 **개조식 구문**으로 작성

영어로 작성하는 경우

- 첫 글자는 **대문자**로 시작
- **Fix, Add, Change** 의 명령어로 시작

한글로 작성하는 경우

- **고침, 추가, 변경** 의 명령어로 시작

예시 - Feat: 추가 login api

#### 본문 작성 방법

- 본문은 **한 줄당 72자 내**로 작성
- 양에 구애받지 않고 **최대한 상세히 작성**
- **무엇을 왜 변경했는지 설명**

#### 꼬리말 작성 방법

- 꼬리말은 선택이고 이슈 트래커 ID 를 작성한다
- 꼬리말은 “유형: #이슈 번호” 형식으로 사용
- 여러 개의 이슈 번호를 적을 때는 쉼표로 구분
- 이슈 트래커 유형은 다음 중 하나를 사용
    - Fixes: 이슈 수정중
    - Resolves: 이슈 해결함
    - Ref: 참고할 이슈
    - Related to: 해당 커밋에 관련된 이슈번호
- ex) Fixes: #45 Related to: #34, #23

#### 예시

```swift
Feat: "네이버 지도 연동"

네이버 지도 연동 및 SwiftUI 로 뷰 구성
다양한 해상도 대응을 위해 AutoLayout 로 구성

Resolves: #12
Ref: #5
Related to: #1, #2
```

### gitignore

- .DS_Store
- xcuserdata/

### gitattributes

- *.pbxproj binary merge=union

<br>

## 🔒 License

- [MIT License](./LICENSE)

<br>
