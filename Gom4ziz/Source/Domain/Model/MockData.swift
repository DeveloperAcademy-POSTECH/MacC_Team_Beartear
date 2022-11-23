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
             firstLoginedDate: Date().yyyyMMddHHmmFormattedInt!)
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
        ArtworkReview(review: "정말 운동에 미친 사람이구나",
                      timeStamp: 20220903122333,
                      uid: "mock")
    }
}

extension ArtworkDescription {
    static var mockData: ArtworkDescription {
        ArtworkDescription(id: 1,
                           content: .lorenIpsum)
    }
}

extension QuestionAnswer {
    static var mockData: QuestionAnswer {
        QuestionAnswer(questionAnswer: "정말 개발에 미친 사람이구나? 정말 개발에 미친 사람이구나? 정말 개발에 미친 사람이구나? 정말 개발에 미친 사람이구나?",
                       timeStamp: 20220903122333,
                       uid: "mock")
    }
}

extension String {
    
    /// 개발용 긴 문장
    static var lorenIpsum: String {
        """
국회는 국무총리 또는 국무위원의 해임을 대통령에게 건의할 수 있다. 국회는 의장 1인과 부의장 2인을 선출한다. 국가는 농업 및 어업을 보호·육성하기 위하여 농·어촌종합개발과 그 지원등 필요한 계획을 수립·시행하여야 한다. 형사피의자 또는 형사피고인으로서 구금되었던 자가 법률이 정하는 불기소처분을 받거나 무죄판결을 받은 때에는 법률이 정하는 바에 의하여 국가에 정당한 보상을 청구할 수 있다.

모든 국민은 고문을 받지 아니하며, 형사상 자기에게 불리한 진술을 강요당하지 아니한다. 대통령은 필요하다고 인정할 때에는 외교·국방·통일 기타 국가안위에 관한 중요정책을 국민투표에 붙일 수 있다. 모든 국민은 건강하고 쾌적한 환경에서 생활할 권리를 가지며, 국가와 국민은 환경보전을 위하여 노력하여야 한다.

모든 국민은 통신의 비밀을 침해받지 아니한다. 국정의 중요한 사항에 관한 대통령의 자문에 응하기 위하여 국가원로로 구성되는 국가원로자문회의를 둘 수 있다. 공무원인 근로자는 법률이 정하는 자에 한하여 단결권·단체교섭권 및 단체행동권을 가진다. 평화통일정책의 수립에 관한 대통령의 자문에 응하기 위하여 민주평화통일자문회의를 둘 수 있다.

위원은 정당에 가입하거나 정치에 관여할 수 없다. 대통령의 임기연장 또는 중임변경을 위한 헌법개정은 그 헌법개정 제안 당시의 대통령에 대하여는 효력이 없다. 제안된 헌법개정안은 대통령이 20일 이상의 기간 이를 공고하여야 한다. 대통령·국무총리·국무위원·행정각부의 장·헌법재판소 재판관·법관·중앙선거관리위원회 위원·감사원장·감사위원 기타 법률이 정한 공무원이 그 직무집행에 있어서 헌법이나 법률을 위배한 때에는 국회는 탄핵의 소추를 의결할 수 있다.

모든 국민은 헌법과 법률이 정한 법관에 의하여 법률에 의한 재판을 받을 권리를 가진다. 일반사면을 명하려면 국회의 동의를 얻어야 한다. 정부는 회계연도마다 예산안을 편성하여 회계연도 개시 90일전까지 국회에 제출하고, 국회는 회계연도 개시 30일전까지 이를 의결하여야 한다. 국회의원이 회기전에 체포 또는 구금된 때에는 현행범인이 아닌 한 국회의 요구가 있으면 회기중 석방된다.

공무원의 직무상 불법행위로 손해를 받은 국민은 법률이 정하는 바에 의하여 국가 또는 공공단체에 정당한 배상을 청구할 수 있다. 이 경우 공무원 자신의 책임은 면제되지 아니한다. 국무회의는 정부의 권한에 속하는 중요한 정책을 심의한다. 사법권은 법관으로 구성된 법원에 속한다. 국회의원과 정부는 법률안을 제출할 수 있다.
"""
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
