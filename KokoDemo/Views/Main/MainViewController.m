//
//  MainViewController.m
//  KokoDemo
//
//  Created by Alex Zhang on 2021/3/9.
//  Copyright © 2021 Alex Zhang. All rights reserved.
//

#import "MainViewController.h"
#import "ViewModel.h"
#import "Utilitie.h"
#import "UserInfoView.h"
#import "MiddleView.h"
#import "CustomTableViewCell.h"
#import "CustomSegmentedControl.h"
#import "InviteItemView.h"
#import "GradualView.h"
#import "CustomSearchBarView.h"
#import "AppConfig.h"
#import "InviteListView.h"
@interface MainViewController ()<UISearchBarDelegate>
{
    AppConfig *appconfig;
}
@property (strong, nonatomic) IBOutlet UIStackView *topStackView;
@property (strong, nonatomic) IBOutlet MiddleView *noDataMiddleView;
@property (strong, nonatomic) IBOutlet CustomSearchBarView *searbarView;
@property (strong, nonatomic) IBOutlet UITableView *friendsTableView;
@property (strong, nonatomic) IBOutlet InviteListView *inviteList;

@property (nonatomic, strong) ViewModel * viewModel;
@property (nonatomic, strong) IBOutlet UserInfoView *userInfoView;
@property (nonatomic, strong) UIView *selectView;
@property (nonatomic, strong) UITableView *inviteItemsTableView;

@property (nonatomic, strong) NSMutableArray *searchContentList;
@property (nonatomic) UISearchBar *searchbar;
@end

@implementation MainViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.viewModel = [[ViewModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    appconfig = [AppConfig sharedInstance];
    [self getData];
    [self setup];
    
    [self.viewModel addObserver:self forKeyPath:@"friends" options:NSKeyValueObservingOptionNew context:@"friendsChange"];
    [self.viewModel addObserver:self forKeyPath:@"inviteItems" options:NSKeyValueObservingOptionNew context:@"inviteItemsChange"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSString *conStr = CFBridgingRelease(context);
    [self reloadData:conStr];
}

- (void)setup {
    
    switch (appconfig.startModel) {
            
        case StartModel_NoFriend:
            _searbarView.hidden = YES;
            _friendsTableView.hidden = YES;
            [_topStackView removeArrangedSubview:_inviteList];
            break;
            
        case StartModel_OnlyFriend:
        
            _friendsTableView.delegate = self;
            _friendsTableView.dataSource = self;
            _noDataMiddleView.hidden = YES;
            self.searbarView.searchBar.delegate = self;
            
//            UIView *listView = _topStackView.arrangedSubviews[1];
//            listView.hidden = YES;
            
            
            _friendsTableView.tableFooterView = [UIView new];
            
            
            break;
        
        case StartModel_FriendAndinvite:
            _friendsTableView.delegate = self;
            _friendsTableView.dataSource = self;
            _noDataMiddleView.hidden = YES;
            _friendsTableView.tableFooterView = [UIView new];
            
            
            break;
            
    }
    
    
}


- (void)getData {
    [self getUserInfoData];
    [self getFriendData:appconfig.startModel];
}

- (void)reloadData:(NSString *)context {
    NSLog(@"reLoad");
    __weak MainViewController *mainVC = self;
    if ([context  isEqualToString: @"friendsChange"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [mainVC.friendsTableView reloadData];
            [mainVC.inviteItemsTableView reloadData];
            [mainVC.inviteList setData:self.viewModel.inviteItems];
        });
        
    }else if ([context isEqualToString: @"inviteItems"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [mainVC.inviteList setData:self.viewModel.inviteItems];
        });
    }
    
}

///依照模式 呼叫對應的API
- (void)getFriendData:(NSInteger)modelInt {
    
    
    switch (modelInt) {
        case 1:
        {
            [self.viewModel getFriendURL:kAPIURL_friend4 WithSuccess:^(NSArray<Friend *> * _Nullable firends) {
            } error:^(NSError * _Nonnull error) {
            }];
            break;
        }
        case 2:
        {
            [self.viewModel getFriendURL:kAPIURL_friend1 WithSuccess:^(NSArray<Friend *> * _Nullable firends) {
            } error:^(NSError * _Nonnull error) {
            }];
            
            [self.viewModel getFriendURL:kAPIURL_friend2 WithSuccess:^(NSArray<Friend *> * _Nullable firends) {
            } error:^(NSError * _Nonnull error) {
            }];
            break;
        }
            
        case 3:
        {
            [self.viewModel getFriendURL:kAPIURL_friend3 WithSuccess:^(NSArray<Friend *> * _Nullable firends) {
            } error:^(NSError * _Nonnull error) {
            }];
            break;
        }
        default:
        {
            break;
        }
    }
    
    
}

- (void)getUserInfoData {
    
    [self.viewModel getUserInfoURL:kAPIURL_UserInfo WithSuccess:^(UserInfo * _Nonnull userInfo) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.userInfoView.userNameLabel.text = userInfo.name;
            self.userInfoView.userKokoIDLabel.text = [self.userInfoView.userKokoIDLabel.text stringByAppendingString:userInfo.kokoid];
            self->_userInfoView.userPinkView.hidden = YES;
            
        });
        
    } error:^(NSError * _Nonnull error) {
        
    }];
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"friends" context:@"friendsChange"];
    [self removeObserver:self forKeyPath:@"inviteItems" context:@"friendsChange"];
}

#pragma mark - TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchContentList.count != 0) {
        return self.searchContentList.count;
    }
    if ([tableView isEqual:self.friendsTableView]) {
        return self.viewModel.numberOfFriends;
    }
    else
    {
        return self.viewModel.numberOfinviteItems;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"CustomTableViewCell" owner:nil options:nil];
        
        for (UIView *view in views) {
            if ([view isKindOfClass:[CustomTableViewCell class]]){
                cell = (CustomTableViewCell *)view;
            }
        }
    }
    
    if (!cell) {
        assert(false);
    }
    if ([tableView isEqual:self.friendsTableView]) {
        [cell setDisplay:[self.viewModel friendsAtIndexPath:indexPath]];
    } else {
        [cell setDisplay:[self.viewModel inviteItemsAtIndexPath:indexPath]];
    }
    
    return cell;
}



#pragma mark - KB Event

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}

#pragma mark - SearchBar Delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"SearCh %@",searchText);
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    NSLog(@"开始输入搜索内容");

}
@end
