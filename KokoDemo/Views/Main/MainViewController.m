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


#define kDataConfig 1

@interface MainViewController ()

@property (nonatomic, strong) ViewModel * viewModel;
@property (nonatomic, strong) UserInfoView *userInfoView;
@property (nonatomic, strong) UIView *selectView;
@property (nonatomic, strong) MiddleView *middleView;
@property (nonatomic, strong) UITableView *friendsTableView;
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
    [self getData];
    [self setup];
    
    [self.viewModel addObserver:self forKeyPath:@"friends" options:NSKeyValueObservingOptionNew context:@"friendsChange"];
    [self.viewModel addObserver:self forKeyPath:@"inviteItems" options:NSKeyValueObservingOptionNew context:@"friendsChange"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (context == @"friendsChange") {
        [self reloadData];
    }
}

- (void)setup {
    
    self.userInfoView = [[UserInfoView alloc] initWithFrame:CGRectMake(0, 0, [Utilitie getScreenWidth], 137)];
    [self.view addSubview:self.userInfoView];
    
    self.selectView = [[UIView alloc]initWithFrame:CGRectMake(0, 138, [Utilitie getScreenWidth], 192 - 164)];
    [self.view addSubview:self.selectView];

    if (kDataConfig == 1) {
        self.middleView = [[MiddleView alloc] initWithFrame:CGRectMake(0, 192, [Utilitie getScreenWidth], 445)];
        [self.view addSubview:self.middleView];
        
    } else {
        self.friendsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 260, [Utilitie getScreenWidth], 445)];
        self.friendsTableView.delegate = self;
        self.friendsTableView.dataSource = self;
        [self.view addSubview:self.friendsTableView];
    }
    
    if (kDataConfig == 3) {
        self.inviteItemsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 138, [Utilitie getScreenWidth], 100)];
        self.inviteItemsTableView.delegate = self;
        self.inviteItemsTableView.dataSource = self;
        [self.view addSubview:self.inviteItemsTableView];
    }

//    self.searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 60, [Utilitie getScreenWidth], 60)];
//    self.searchbar.placeholder = @"想轉一筆給誰呢？";
//    [self.view addSubview:self.searchbar];
    
    
    
//    CustomSegmentedControl *seg = [[CustomSegmentedControl alloc] initWithItems:@[@"好友",@"聊天"]];
//    seg.frame = CGRectMake(10, 200, 100, 40);
//    
//    [self.view addSubview:seg];
//    
//    InviteItemView *temp = [[InviteItemView alloc] initWithFrame:CGRectMake(30, 149, 315, 70)];
//    temp.layer.borderWidth = 2.0;
//    [self.view addSubview:temp];
    
    
    GradualView *view = [[GradualView alloc] initWithFrame:CGRectMake(92, 537, 192, 40)];

    [self.view addSubview:view];
}


- (void)getData {
    [self getUserInfoData];
    [self getFriendData:kDataConfig];
}

- (void)reloadData {
    NSLog(@"reLoad");
    __weak MainViewController *mainVC = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [mainVC.friendsTableView reloadData];
        [mainVC.inviteItemsTableView reloadData];
    });
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
            self.userInfoView.userPinkView.hidden = YES;
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
//    self.searchContentList =
}

@end
