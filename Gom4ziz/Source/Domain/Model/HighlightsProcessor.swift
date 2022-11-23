//
//  HighlightsProcessor.swift
//  Gom4ziz
//
//  Created by JongHo Park on 2022/11/22.
//

struct HighlightProcessor {

    /// 범위가 겹치는 하이라이트가 있으면, 하나의 하이라이트로 변환하는 함수입니다.
    /// - Parameter highlights: 변환 전 하이라이트 들
    /// - Returns: 변환 후 하이라이트들
    func processHighlights(_ highlights: [Highlight]) -> [Highlight] {
        var checkQueue: [Highlight] = highlights.sorted { first, second in
            if first.start < second.start {
                return true
            } else if first.start == second.start {
                return first.end < second.end
            } else {
                return false
            }
        }.reversed()

        var ret: [Highlight] = []

        while !checkQueue.isEmpty {
            // 만약 검사할 하이라이트가 한개 밖에 없으면, ret에 append한 후 바로 종료
            guard checkQueue.count > 1 else {
                ret.append(checkQueue.removeLast())
                continue
            }
            let first: Highlight = checkQueue.last!
            let second: Highlight = checkQueue.beforeLast!
            // 만약 검사할 하이라이트가 2개 이상 있어도, 이번 하이라이트랑 다음 하이라이트랑 겹치지 않는다면 이번 것을 ret에 추가한다! (겹치지 않음)
            guard first.end >= second.start else {
                ret.append(checkQueue.removeLast())
                continue
            }
            // 두 개가 겹친다면, 일단 2개를 지움!
            checkQueue.removeLast(2)
            // 겹치는 두 개를 합친다.
            let combined: Highlight = Highlight(start: first.start, end: Swift.max(first.end, second.end))
            // 다시 합쳐진 하이라이트를 검사 대기열에 추가한다.
            checkQueue.append(combined)
        }

        return ret
    }

}
