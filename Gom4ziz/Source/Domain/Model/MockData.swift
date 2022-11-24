//
//  MockData.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/21.
//

#if DEBUG
import Foundation

extension User {
    static var mockData: User {
        User(id: "mock",
             lastArtworkId: 5,
             firstLoginedDate: Date().yyyyMMddHHmmssFormattedInt!)
    }
}

extension Artwork {
    static var mockData: Artwork {
        Artwork(id: 1,
                imageUrl: "",
                question: "당신에게 있어서 방주란 무엇인가요?",
                title: "작은 방주",
                artist: "최우람")
    }

    static var mockDatas: [Artwork] {
        [
            Artwork(id: 1,
                    imageUrl: "",
                    question: "당신에게 있어서 방주란 무엇인가요?",
                    title: "작은 방주",
                    artist: "최우람"),
            Artwork(id: 2,
                    imageUrl: "",
                    question: "당신에게 있어서 개발이란 무엇인가요?",
                    title: "내돈내산 키보드",
                    artist: "개발자"),
            Artwork(id: 3,
                    imageUrl: "",
                    question: "당신에게 있어서 디자인이란 무엇인가요?",
                    title: "실력이 미친 디자이너",
                    artist: "이솝"),
            Artwork(id: 4,
                    imageUrl: "",
                    question: "당신에게 있어서 운동이란 무엇인가요?",
                    title: "운동에 미친 남자",
                    artist: "성수핫보이"),
            Artwork(id: 5,
                    imageUrl: "",
                    question: "당신에게 있어서 아카데미란 무엇인가요?",
                    title: "아카데미",
                    artist: "레이몬드")
        ]
    }
}

extension ArtworkReview {
    static var mockData: ArtworkReview {
        ArtworkReview(id: "mock",
                      questionAnswer: "저에게 있어 운동이란 마약과도 같죠",
                      review: "정말 운동에 미친 사람이구나",
                      timeStamp: Date(),
                      uid: "mock")
    }
}

extension ArtworkDescription {
    static var mockData: ArtworkDescription {
        ArtworkDescription(id: 1,
                           content: """
                           운동에 미친 사람은 어떤 사람일까?운동에 미친 사람은 어떤 사람일까?운동에 미친 사람은 어떤 사람일까?
                           운동에 미친 사람은 어떤 사람일까?운동에 미친 사람은 어떤 사람일까?운동에 미친 사람은 어떤 사람일까?
                           운동에 미친 사람은 어떤 사람일까?운동에 미친 사람은 어떤 사람일까?운동에 미친 사람은 어떤 사람일까?
                           운동에 미친 사람은 어떤 사람일까?운동에 미친 사람은 어떤 사람일까?운동에 미친 사람은 어떤 사람일까?
                           운동에 미친 사람은 어떤 사람일까?운동에 미친 사람은 어떤 사람일까?운동에 미친 사람은 어떤 사람일까?
                           운동에 미친 사람은 어떤 사람일까?운동에 미친 사람은 어떤 사람일까?운동에 미친 사람은 어떤 사람일까?
                           운동에 미친 사람은 어떤 사람일까?운동에 미친 사람은 어떤 사람일까?운동에 미친 사람은 어떤 사람일까?
                           운동에 미친 사람은 어떤 사람일까?운동에 미친 사람은 어떤 사람일까?운동에 미친 사람은 어떤 사람일까?
                           운동에 미친 사람은 어떤 사람일까?운동에 미친 사람은 어떤 사람일까?운동에 미친 사람은 어떤 사람일까?
                           운동에 미친 사람은 어떤 사람일까?운동에 미친 사람은 어떤 사람일까?운동에 미친 사람은 어떤 사람일까?
                           운동에 미친 사람은 어떤 사람일까?운동에 미친 사람은 어떤 사람일까?운동에 미친 사람은 어떤 사람일까?
                           운동에 미친 사람은 어떤 사람일까?운동에 미친 사람은 어떤 사람일까?운동에 미친 사람은 어떤 사람일까?
                           운동에 미친 사람은 어떤 사람일까?운동에 미친 사람은 어떤 사람일까?운동에 미친 사람은 어떤 사람일까?
""")
    }
}

extension Highlight {
    static var mockData: [Highlight] {
        [
            Highlight(start: 1, end: 10),
            Highlight(start: 22, end: 30),
            Highlight(start: 35, end: 38)
        ]
    }
}
#endif
