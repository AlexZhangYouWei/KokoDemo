//
//  TestViewController.m
//  KokoDemo
//
//  Created by Alex on 2021/3/11.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import "TestViewController.h"
#import <Vision/Vision.h>
#import <AVFoundation/AVFoundation.h>

@interface TestViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UILabel *introLabel;
@property (nonatomic, strong) UIImageView *previewImageView;
@property (nonatomic, strong) UILabel *resultTitleLabel;
@property (nonatomic, strong) UITextView *resultTextView;
@property (nonatomic, strong) UIButton *cameraButton;
@property (nonatomic, strong) UIButton *albumButton;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"攝影助手";
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    [self setupViews];
}

- (void)setupViews {
    self.introLabel = [[UILabel alloc] init];
    self.introLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.introLabel.numberOfLines = 0;
    self.introLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    self.introLabel.text = @"拍一張有人物的照片，我會根據背景人物的位置與數量，給你最佳拍攝提示。";

    self.previewImageView = [[UIImageView alloc] init];
    self.previewImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.previewImageView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    self.previewImageView.layer.cornerRadius = 12;
    self.previewImageView.layer.masksToBounds = YES;
    self.previewImageView.contentMode = UIViewContentModeScaleAspectFill;

    self.cameraButton = [self actionButtonWithTitle:@"拍照" selector:@selector(tapCamera)];
    self.albumButton = [self actionButtonWithTitle:@"從相簿選擇" selector:@selector(tapAlbum)];

    UIStackView *buttonStack = [[UIStackView alloc] initWithArrangedSubviews:@[self.cameraButton, self.albumButton]];
    buttonStack.translatesAutoresizingMaskIntoConstraints = NO;
    buttonStack.axis = UILayoutConstraintAxisHorizontal;
    buttonStack.spacing = 12;
    buttonStack.distribution = UIStackViewDistributionFillEqually;

    self.resultTitleLabel = [[UILabel alloc] init];
    self.resultTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.resultTitleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.resultTitleLabel.text = @"攝影建議";

    self.resultTextView = [[UITextView alloc] init];
    self.resultTextView.translatesAutoresizingMaskIntoConstraints = NO;
    self.resultTextView.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1.0];
    self.resultTextView.layer.cornerRadius = 12;
    self.resultTextView.editable = NO;
    self.resultTextView.scrollEnabled = YES;
    self.resultTextView.font = [UIFont systemFontOfSize:14];
    self.resultTextView.text = @"1. 讓人物先站在畫面中線附近。\n2. 預留頭頂空間，避免切到臉。\n3. 如果背景人物太多，建議靠近主體或改用長焦構圖。";

    [self.view addSubview:self.introLabel];
    [self.view addSubview:self.previewImageView];
    [self.view addSubview:buttonStack];
    [self.view addSubview:self.resultTitleLabel];
    [self.view addSubview:self.resultTextView];

    UILayoutGuide *safeArea = self.view.safeAreaLayoutGuide;
    [NSLayoutConstraint activateConstraints:@[
        [self.introLabel.topAnchor constraintEqualToAnchor:safeArea.topAnchor constant:16],
        [self.introLabel.leadingAnchor constraintEqualToAnchor:safeArea.leadingAnchor constant:16],
        [self.introLabel.trailingAnchor constraintEqualToAnchor:safeArea.trailingAnchor constant:-16],

        [self.previewImageView.topAnchor constraintEqualToAnchor:self.introLabel.bottomAnchor constant:12],
        [self.previewImageView.leadingAnchor constraintEqualToAnchor:safeArea.leadingAnchor constant:16],
        [self.previewImageView.trailingAnchor constraintEqualToAnchor:safeArea.trailingAnchor constant:-16],
        [self.previewImageView.heightAnchor constraintEqualToConstant:240],

        [buttonStack.topAnchor constraintEqualToAnchor:self.previewImageView.bottomAnchor constant:12],
        [buttonStack.leadingAnchor constraintEqualToAnchor:safeArea.leadingAnchor constant:16],
        [buttonStack.trailingAnchor constraintEqualToAnchor:safeArea.trailingAnchor constant:-16],
        [buttonStack.heightAnchor constraintEqualToConstant:44],

        [self.resultTitleLabel.topAnchor constraintEqualToAnchor:buttonStack.bottomAnchor constant:16],
        [self.resultTitleLabel.leadingAnchor constraintEqualToAnchor:safeArea.leadingAnchor constant:16],
        [self.resultTitleLabel.trailingAnchor constraintEqualToAnchor:safeArea.trailingAnchor constant:-16],

        [self.resultTextView.topAnchor constraintEqualToAnchor:self.resultTitleLabel.bottomAnchor constant:8],
        [self.resultTextView.leadingAnchor constraintEqualToAnchor:safeArea.leadingAnchor constant:16],
        [self.resultTextView.trailingAnchor constraintEqualToAnchor:safeArea.trailingAnchor constant:-16],
        [self.resultTextView.bottomAnchor constraintEqualToAnchor:safeArea.bottomAnchor constant:-16]
    ]];
}

- (UIButton *)actionButtonWithTitle:(NSString *)title selector:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    button.backgroundColor = [UIColor systemBlueColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    button.layer.cornerRadius = 10;
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)tapCamera {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self showHint:@"此裝置不支援相機，請改用相簿選擇。"];
        return;
    }
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusDenied || status == AVAuthorizationStatusRestricted) {
        [self showHint:@"相機權限被關閉，請到系統設定開啟後再試。"];
        return;
    }
    [self presentPickerWithSource:UIImagePickerControllerSourceTypeCamera];
}

- (void)tapAlbum {
    [self presentPickerWithSource:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)presentPickerWithSource:(UIImagePickerControllerSourceType)sourceType {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = sourceType;
    picker.allowsEditing = NO;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];

    if (!image) {
        [self showHint:@"無法讀取照片，請再試一次。"];
        return;
    }

    self.previewImageView.image = image;
    self.resultTextView.text = @"分析中，請稍候…";
    [self analyzePeopleInImage:image];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)analyzePeopleInImage:(UIImage *)image {
    CGImageRef cgImage = image.CGImage;
    if (!cgImage) {
        [self showHint:@"照片格式不支援分析，請改用其他照片。"];
        return;
    }

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        VNDetectFaceRectanglesRequest *request = [[VNDetectFaceRectanglesRequest alloc] init];
        VNImageRequestHandler *handler = [[VNImageRequestHandler alloc] initWithCGImage:cgImage options:@{}];
        NSError *error = nil;
        [handler performRequests:@[request] error:&error];

        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                [self showHint:@"人物偵測失敗，請換一張清楚的人像照片。"];
                return;
            }

            NSArray<VNFaceObservation *> *faces = request.results;
            self.resultTextView.text = [self suggestionTextForFaces:faces];
        });
    });
}

- (NSString *)suggestionTextForFaces:(NSArray<VNFaceObservation *> *)faces {
    if (faces.count == 0) {
        return @"沒有偵測到人物。\n\n建議：\n1. 讓人物更靠近鏡頭。\n2. 確保臉部光線足夠，避免逆光。\n3. 對焦在人臉後再按快門。";
    }

    VNFaceObservation *mainFace = faces.firstObject;
    for (VNFaceObservation *face in faces) {
        if (face.boundingBox.size.width * face.boundingBox.size.height > mainFace.boundingBox.size.width * mainFace.boundingBox.size.height) {
            mainFace = face;
        }
    }

    CGFloat centerX = CGRectGetMidX(mainFace.boundingBox);
    CGFloat topY = CGRectGetMaxY(mainFace.boundingBox);
    NSMutableArray<NSString *> *tips = [NSMutableArray array];
    [tips addObject:[NSString stringWithFormat:@"偵測到 %lu 位人物。", (unsigned long)faces.count]];

    if (centerX < 0.35) {
        [tips addObject:@"主體偏左：建議向右平移鏡頭，讓人物落在三分線附近。"];
    } else if (centerX > 0.65) {
        [tips addObject:@"主體偏右：建議向左平移鏡頭，讓構圖更平衡。"];
    } else {
        [tips addObject:@"主體位置良好：目前水平構圖平衡，可直接拍攝。"];
    }

    if (topY > 0.9) {
        [tips addObject:@"頭頂空間過少：請稍微後退或下壓鏡頭，避免切到頭部。"];
    } else if (topY < 0.65) {
        [tips addObject:@"頭頂空間較多：可上移人物或放大，減少空白提升聚焦感。"];
    } else {
        [tips addObject:@"頭部留白適中：可保留目前垂直構圖。"];
    }

    if (faces.count >= 4) {
        [tips addObject:@"背景人物較多：建議使用人像模式或靠近主體，降低背景干擾。"];
    } else if (faces.count == 1) {
        [tips addObject:@"單人場景：建議開啟人像模式，背景虛化能讓主角更突出。"];
    } else {
        [tips addObject:@"多人場景：提醒大家視線看鏡頭，並連拍 2-3 張提高成功率。"];
    }

    return [tips componentsJoinedByString:@"\n\n"];
}

- (void)showHint:(NSString *)message {
    self.resultTextView.text = message;
}

@end
