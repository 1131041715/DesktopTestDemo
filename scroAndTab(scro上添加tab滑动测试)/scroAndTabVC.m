//
//  scroAndTabVC.m
//  testbutton
//
//  Created by lmcqc on 2020/11/19.
//  Copyright © 2020 大碗豆. All rights reserved.
//

#import "scroAndTabVC.h"

static CGFloat const kHeaderHeight = 66;
#define ITEM_WIDTH 94

@interface scroAndTabVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIScrollView *scrollVeiw;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation scroAndTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.scrollVeiw.contentSize = CGSizeMake(10 * ITEM_WIDTH, 0);
    self.tableView.frame = CGRectMake(0, kHeaderHeight, 10 * ITEM_WIDTH, self.scrollVeiw.bounds.size.height);
//    self.tableHeader.frame = CGRectMake(0, 0, 10 * ITEM_WIDTH, kHeaderHeight);
    
//    _dataArr = datas[0].groupParamsViewModelList;
//    [self.tableHeader setDatas:datas];
    [self.tableView reloadData];
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (self.delegate && [self.delegate respondsToSelector:@selector(e_scrollViewDidScroll:)]) {
//        [self.delegate e_scrollViewDidScroll:scrollView];
//    }
}
#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([self class])];
    }
    cell.backgroundColor = ANYColorRandom;
    cell.textLabel.text = [NSString stringWithFormat:@"%ld~~~~",(long)indexPath.row];
    return cell;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 40;
        _tableView.sectionHeaderHeight = 0;
        _tableView.bounces = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor orangeColor];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 67, 0);
        [self.scrollVeiw addSubview:_tableView];
    }
    return _tableView;
}


- (UIScrollView *)scrollVeiw {
    if (!_scrollVeiw) {
        _scrollVeiw = [[UIScrollView alloc] initWithFrame:CGRectMake(ITEM_WIDTH, STATUS_NAV_HEIGHT, kScreenWidth - ITEM_WIDTH, kScreenHeight - STATUS_NAV_HEIGHT-TABBAR_SPACE)];
        _scrollVeiw.bounces = NO;
        _scrollVeiw.backgroundColor = [UIColor purpleColor];
        [self.view addSubview:_scrollVeiw];
    }
    return _scrollVeiw;
}

@end
