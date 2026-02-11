#import <XCTest/XCTest.h>
#import "Views/Main/CustomView/CustomSearchBarView.h"

@interface CustomSearchBarViewTests : XCTestCase
@end

@implementation CustomSearchBarViewTests

- (void)testLayoutSubviewsAddsSingleActionImageView {
    CustomSearchBarView *view = [[CustomSearchBarView alloc] initWithFrame:CGRectMake(0, 0, 375, 44)];

    [view layoutSubviews];
    [view layoutSubviews];

    XCTAssertEqual(view.subviews.count, 1);
    UIImageView *actionImageView = (UIImageView *)view.subviews.firstObject;
    XCTAssertTrue([actionImageView isKindOfClass:[UIImageView class]]);
}

- (void)testActionImageViewHasExpectedFrame {
    CustomSearchBarView *view = [[CustomSearchBarView alloc] initWithFrame:CGRectMake(0, 0, 375, 44)];

    [view layoutSubviews];

    UIImageView *actionImageView = (UIImageView *)view.subviews.firstObject;
    XCTAssertTrue(CGRectEqualToRect(actionImageView.frame, CGRectMake(321, 5, 24, 24)));
}

@end
