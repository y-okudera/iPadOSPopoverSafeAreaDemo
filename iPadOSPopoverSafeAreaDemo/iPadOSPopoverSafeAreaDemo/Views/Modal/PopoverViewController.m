//
//  PopoverViewController.m
//  iPadOSPopoverSafeAreaDemo
//
//  Created by Yuki Okudera on 2019/11/30.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

#import "PopoverViewController.h"
#import "UIViewController+StoryBoardInstantiatable.h"

@interface PopoverViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLabelBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottomConstraint;

/// タイトルラベル
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/// リスト
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/// セルの件数
@property (nonatomic) NSInteger cellCount;

/// セーフエリアチェック済みかどうか
@property (nonatomic, getter=alreadyCheckedSafeArea) BOOL safeAreaCheckFlg;
@end

#pragma mark - Const

/// Popoverの幅
static const CGFloat popoverWidth = 500.0;
/// TableViewの高さの上限
static const CGFloat tableViewMaxHeight = 300.0;
/// セルの高さ
static const CGFloat cellHeight = 44.0;
/// セルの件数のデフォルト値
static const NSInteger kDefaultCellCount = 5;

@implementation PopoverViewController

#pragma mark - Instantiate

+ (PopoverViewController *)makeWithSourceView:(UIView *)sourceView cellCount:(NSInteger)count backgroundColor:(UIColor *)color {
    PopoverViewController *popoverViewController = [PopoverViewController instantiate];
    
    if (count == 0) {
        count = kDefaultCellCount;
    }
    
    popoverViewController.cellCount = count;
    
    // preferredContentSizeは、viewWillLayoutSubviewsで更新する
    popoverViewController.modalPresentationStyle = UIModalPresentationPopover;
    popoverViewController.popoverPresentationController.sourceView = sourceView;
    popoverViewController.popoverPresentationController.sourceRect = sourceView.bounds;
    popoverViewController.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
    popoverViewController.popoverPresentationController.backgroundColor = color;
    popoverViewController.view.backgroundColor = color;
    
    return popoverViewController;
}

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.safeAreaCheckFlg = NO;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    NSLog(@"self.view.safeAreaInsets.top = %.2f", self.view.safeAreaInsets.top);
    NSLog(@"self.tableViewBottomConstraint.constant = %.2f", self.tableViewBottomConstraint.constant);
    
    // セーフエリアチェック済みかどうか
    if (!self.alreadyCheckedSafeArea) {
        // セーフエリアがある場合は、TableViewのbottomの制約からセーフエリア分だけ引く
        self.tableViewBottomConstraint.constant -= self.view.safeAreaInsets.top;
        self.safeAreaCheckFlg = YES;
    }
    // セルの高さ * セルの件数
    CGFloat tableViewHeight = (cellHeight * self.cellCount);
    
    // TableViewの高さの上限チェック
    if (tableViewHeight > tableViewMaxHeight) {
        tableViewHeight = tableViewMaxHeight;
    }
    
    // AutoLayoutの制約と各コンポーネントの高さからviewの高さを定義する
    CGFloat height = self.titleLabelTopConstraint.constant
    + self.titleLabel.frame.size.height
    + self.titleLabelBottomConstraint.constant
    + tableViewHeight
    + self.tableViewBottomConstraint.constant;
    
    // viewのframeを取得して、高さを変更する
    CGRect newFrame = self.view.frame;
    newFrame.size.height = height + self.view.safeAreaInsets.top;
    newFrame.size.width = popoverWidth;
    
    // viewのframeとpreferredContentSizeを更新
    self.view.frame = newFrame;
    self.preferredContentSize = newFrame.size;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSLog(@"self.view %@", NSStringFromCGRect(self.view.frame));
    NSLog(@"self.tableView %@", NSStringFromCGRect(self.tableView.frame));
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TheCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"SelectRow: %ld", (long)indexPath.row);
    }];
}

@end
