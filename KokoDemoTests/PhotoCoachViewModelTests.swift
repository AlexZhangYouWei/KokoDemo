import XCTest
@testable import KokoDemo

final class PhotoCoachViewModelTests: XCTestCase {
    func testBuildSuggestion_whenNoFaces_returnsGuidanceForDetectionFailure() {
        let text = PhotoCoachViewModel.buildSuggestion(faces: [])
        XCTAssertTrue(text.contains("沒有偵測到人物"))
    }

    func testBuildSuggestion_whenSingleCenteredFace_returnsBalancedHint() {
        let faces = [FaceBoundingBox(rect: CGRect(x: 0.4, y: 0.3, width: 0.2, height: 0.4))]
        let text = PhotoCoachViewModel.buildSuggestion(faces: faces)

        XCTAssertTrue(text.contains("偵測到 1 位人物"))
        XCTAssertTrue(text.contains("主體位置良好"))
        XCTAssertTrue(text.contains("單人場景"))
    }

    func testAnalyze_whenDetectorFails_setsErrorState() async {
        let viewModel = PhotoCoachViewModel(detector: MockDetector(result: .failure(MockError.detectFail)))
        await viewModel.analyze(imageData: Data([0x01]))

        XCTAssertEqual(viewModel.state, .error("人物偵測失敗，請換一張清楚的人像照片。"))
    }
}

private struct MockDetector: FaceDetecting {
    enum Result {
        case success([FaceBoundingBox])
        case failure(Error)
    }

    let result: Result

    func detectFaces(in imageData: Data) async throws -> [FaceBoundingBox] {
        switch result {
        case let .success(faces):
            return faces
        case let .failure(error):
            throw error
        }
    }
}

private enum MockError: Error {
    case detectFail
}
