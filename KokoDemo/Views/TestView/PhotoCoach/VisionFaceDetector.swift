import Foundation
import Vision
import UIKit

struct VisionFaceDetector: FaceDetecting {
    func detectFaces(in imageData: Data) async throws -> [FaceBoundingBox] {
        guard let image = UIImage(data: imageData), let cgImage = image.cgImage else {
            return []
        }

        return try await withCheckedThrowingContinuation { continuation in
            let request = VNDetectFaceRectanglesRequest { request, error in
                if let error {
                    continuation.resume(throwing: error)
                    return
                }

                let observations = (request.results as? [VNFaceObservation]) ?? []
                let faces = observations.map { FaceBoundingBox(rect: $0.boundingBox) }
                continuation.resume(returning: faces)
            }

            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
                    try handler.perform([request])
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
