import UIKit
import PhotosUI
import AVFoundation

final class PhotoCoachViewController: UIViewController {
    private let introLabel = UILabel()
    private let previewImageView = UIImageView()
    private let resultTitleLabel = UILabel()
    private let resultTextView = UITextView()
    private let cameraButton = UIButton(type: .system)
    private let albumButton = UIButton(type: .system)

    private let viewModel: PhotoCoachViewModel

    required init?(coder: NSCoder) {
        self.viewModel = PhotoCoachViewModel(detector: VisionFaceDetector())
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "攝影助手"
        view.backgroundColor = .systemBackground
        setupViews()
        bindState()
    }

    private func setupViews() {
        introLabel.translatesAutoresizingMaskIntoConstraints = false
        introLabel.numberOfLines = 0
        introLabel.font = .systemFont(ofSize: 15, weight: .medium)
        introLabel.text = "拍一張有人物的照片，我會根據背景人物的位置與數量，給你最佳拍攝提示。"

        previewImageView.translatesAutoresizingMaskIntoConstraints = false
        previewImageView.backgroundColor = .secondarySystemBackground
        previewImageView.layer.cornerRadius = 12
        previewImageView.layer.masksToBounds = true
        previewImageView.contentMode = .scaleAspectFill
        previewImageView.accessibilityIdentifier = "photoCoach.preview"

        setupButton(cameraButton, title: "拍照", action: #selector(tapCamera))
        setupButton(albumButton, title: "從相簿選擇", action: #selector(tapAlbum))

        let buttonStack = UIStackView(arrangedSubviews: [cameraButton, albumButton])
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.axis = .horizontal
        buttonStack.spacing = 12
        buttonStack.distribution = .fillEqually

        resultTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        resultTitleLabel.font = .boldSystemFont(ofSize: 16)
        resultTitleLabel.text = "攝影建議"

        resultTextView.translatesAutoresizingMaskIntoConstraints = false
        resultTextView.backgroundColor = .secondarySystemBackground
        resultTextView.layer.cornerRadius = 12
        resultTextView.isEditable = false
        resultTextView.font = .systemFont(ofSize: 14)
        resultTextView.accessibilityIdentifier = "photoCoach.result"
        resultTextView.text = "1. 讓人物先站在畫面中線附近。\n2. 預留頭頂空間，避免切到臉。\n3. 如果背景人物太多，建議靠近主體或改用長焦構圖。"

        [introLabel, previewImageView, buttonStack, resultTitleLabel, resultTextView].forEach { view.addSubview($0) }

        let safe = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            introLabel.topAnchor.constraint(equalTo: safe.topAnchor, constant: 16),
            introLabel.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 16),
            introLabel.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -16),

            previewImageView.topAnchor.constraint(equalTo: introLabel.bottomAnchor, constant: 12),
            previewImageView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 16),
            previewImageView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -16),
            previewImageView.heightAnchor.constraint(equalToConstant: 240),

            buttonStack.topAnchor.constraint(equalTo: previewImageView.bottomAnchor, constant: 12),
            buttonStack.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 16),
            buttonStack.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -16),
            buttonStack.heightAnchor.constraint(equalToConstant: 44),

            resultTitleLabel.topAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: 16),
            resultTitleLabel.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 16),
            resultTitleLabel.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -16),

            resultTextView.topAnchor.constraint(equalTo: resultTitleLabel.bottomAnchor, constant: 8),
            resultTextView.leadingAnchor.constraint(equalTo: safe.leadingAnchor, constant: 16),
            resultTextView.trailingAnchor.constraint(equalTo: safe.trailingAnchor, constant: -16),
            resultTextView.bottomAnchor.constraint(equalTo: safe.bottomAnchor, constant: -16)
        ])
    }

    private func setupButton(_ button: UIButton, title: String, action: Selector) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
    }

    private func bindState() {
        if case .idle = viewModel.state {
            resultTextView.text = "1. 讓人物先站在畫面中線附近。\n2. 預留頭頂空間，避免切到臉。\n3. 如果背景人物太多，建議靠近主體或改用長焦構圖。"
        }
    }

    @objc private func tapCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            renderHint("此裝置不支援相機，請改用相簿選擇。")
            return
        }

        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            presentPicker(sourceType: .camera)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                DispatchQueue.main.async {
                    guard let self else { return }
                    granted ? self.presentPicker(sourceType: .camera) : self.renderHint("相機權限未開啟，請到系統設定允許存取相機。")
                }
            }
        case .denied, .restricted:
            renderHint("相機權限被關閉，請到系統設定開啟後再試。")
        @unknown default:
            renderHint("無法取得相機權限狀態。")
        }
    }

    @objc private func tapAlbum() {
        if #available(iOS 17.0, *) {
            var configuration = PHPickerConfiguration(photoLibrary: .shared())
            configuration.selectionLimit = 1
            configuration.filter = .images
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            present(picker, animated: true)
            return
        }

        presentPicker(sourceType: .photoLibrary)
    }

    private func presentPicker(sourceType: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        picker.allowsEditing = false
        present(picker, animated: true)
    }

    private func updateForImage(_ image: UIImage) {
        previewImageView.image = image
        guard let data = image.jpegData(compressionQuality: 0.95) else {
            renderHint("無法讀取照片，請再試一次。")
            return
        }

        resultTextView.text = "分析中，請稍候…"

        Task { [weak self] in
            guard let self else { return }
            await viewModel.analyze(imageData: data)
            switch viewModel.state {
            case let .result(text):
                resultTextView.text = text
            case let .error(text):
                resultTextView.text = text
            case .idle:
                break
            }
        }
    }

    private func renderHint(_ message: String) {
        resultTextView.text = message
    }
}

extension PhotoCoachViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[.originalImage] as? UIImage else {
            renderHint("無法讀取照片，請再試一次。")
            return
        }
        updateForImage(image)
    }
}

extension PhotoCoachViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        guard let provider = results.first?.itemProvider else { return }
        if provider.canLoadObject(ofClass: UIImage.self) {
            provider.loadObject(ofClass: UIImage.self) { [weak self] object, _ in
                guard let self, let image = object as? UIImage else { return }
                DispatchQueue.main.async {
                    self.updateForImage(image)
                }
            }
        }
    }
}
