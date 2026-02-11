import Foundation
import CoreGraphics

struct FaceBoundingBox: Equatable {
    let rect: CGRect

    var centerX: CGFloat { rect.midX }
    var topY: CGFloat { rect.maxY }
    var area: CGFloat { rect.width * rect.height }
}

protocol FaceDetecting {
    func detectFaces(in imageData: Data) async throws -> [FaceBoundingBox]
}

@MainActor
final class PhotoCoachViewModel {
    enum State: Equatable {
        case idle
        case analyzing
        case result(String)
        case error(String)
    }

    private let detector: FaceDetecting
    private(set) var state: State = .idle

    init(detector: FaceDetecting) {
        self.detector = detector
    }

    func analyze(imageData: Data) async {
        state = .analyzing
        do {
            let faces = try await detector.detectFaces(in: imageData)
            state = .result(Self.buildSuggestion(faces: faces))
        } catch {
            state = .error("人物偵測失敗，請換一張清楚的人像照片。")
        }
    }

    static func buildSuggestion(faces: [FaceBoundingBox]) -> String {
        guard !faces.isEmpty else {
            return "沒有偵測到人物。\n\n建議：\n1. 讓人物更靠近鏡頭。\n2. 確保臉部光線足夠，避免逆光。\n3. 對焦在人臉後再按快門。"
        }

        let mainFace = faces.max(by: { $0.area < $1.area }) ?? faces[0]
        var tips: [String] = ["偵測到 \(faces.count) 位人物。"]

        if mainFace.centerX < 0.35 {
            tips.append("主體偏左：建議向右平移鏡頭，讓人物落在三分線附近。")
        } else if mainFace.centerX > 0.65 {
            tips.append("主體偏右：建議向左平移鏡頭，讓構圖更平衡。")
        } else {
            tips.append("主體位置良好：目前水平構圖平衡，可直接拍攝。")
        }

        if mainFace.topY > 0.9 {
            tips.append("頭頂空間過少：請稍微後退或下壓鏡頭，避免切到頭部。")
        } else if mainFace.topY < 0.65 {
            tips.append("頭頂空間較多：可上移人物或放大，減少空白提升聚焦感。")
        } else {
            tips.append("頭部留白適中：可保留目前垂直構圖。")
        }

        if faces.count >= 4 {
            tips.append("背景人物較多：建議使用人像模式或靠近主體，降低背景干擾。")
        } else if faces.count == 1 {
            tips.append("單人場景：建議開啟人像模式，背景虛化能讓主角更突出。")
        } else {
            tips.append("多人場景：提醒大家視線看鏡頭，並連拍 2-3 張提高成功率。")
        }

        return tips.joined(separator: "\n\n")
    }
}
