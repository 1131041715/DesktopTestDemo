//
//  SelectLabelShowVC.m
//  testbutton
//
//  Created by 大豌豆 on 20/J/1.
//  Copyright © 2020 大碗豆. All rights reserved.
//

#import "SelectLabelShowVC.h"
#import "TopConditionCollectionView.h"
#import "YYFilterToolMacro.h"
#import "TopConditionCell.h"

@interface SelectLabelShowVC ()
/* 头部的条件框collectionView */
@property (nonatomic, strong) TopConditionCollectionView *topConditionCollectionView;

@property (nonatomic, strong) NSMutableArray *condtionArray;
@end

@implementation SelectLabelShowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(topFilterDeleteBtnClick:) name:FilterViewTopCollectionDeleteBtnClick object:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.condtionArray = [NSMutableArray arrayWithArray:@[@"司法案例查询",@"司法执行查询",@"司法失信查询",@"税务执法查询",@"催欠公告查询",@"网贷逾期查询"]];
    //顶部已经筛选的条件
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _topConditionCollectionView = [[TopConditionCollectionView alloc] initWithFrame:CGRectMake(0, 80, 400, 50) collectionViewLayout:layout];
    _topConditionCollectionView.backgroundColor = [UIColor orangeColor];
    _topConditionCollectionView.showsHorizontalScrollIndicator = NO;
    _topConditionCollectionView.conditions = self.condtionArray;
    [self.view addSubview:_topConditionCollectionView];
}

#pragma mark - Notification Func
- (void)topFilterDeleteBtnClick:(NSNotification *)notification {
    //得到当前点击的按钮的序号
    NSDictionary *userInfo = notification.userInfo;
    TopConditionCell *tmpCell = (TopConditionCell *)userInfo[@"cell"];
    NSIndexPath *indexPath = [_topConditionCollectionView indexPathForCell:tmpCell];
    [self.condtionArray removeObjectAtIndex:indexPath.row];
    _topConditionCollectionView.conditions = self.condtionArray;
    [_topConditionCollectionView reloadData];
    
    NSLog(@"%zd",indexPath.row);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
