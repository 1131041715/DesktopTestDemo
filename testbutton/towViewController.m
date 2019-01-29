//
//  towViewController.m
//  testbutton
//
//  Created by 大碗豆 on 17/11/21.
//  Copyright © 2017年 大碗豆. All rights reserved.
//

#import "towViewController.h"
#import "TXScrollLabelView.h"

static NSTimeInterval const kTransformPart1AnimationDuration = 0.3;

@interface towViewController ()<UIGestureRecognizerDelegate,TXScrollLabelViewDelegate>

@property (nonatomic, strong) UIImageView *image;

@property (assign, nonatomic) IBInspectable BOOL isArray;

@end

@implementation towViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor purpleColor];
    UIButton *btn = [UIButton new];
    btn.frame = CGRectMake(100, 100, 220, 50);
    btn.backgroundColor = [UIColor orangeColor];
    btn.titleLabel.text = @"123";
    [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(actionBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
    //label文字滚动
    [self setViewInfos];
    [self setSubviews];
    
}

- (void)setViewInfos {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"TXScrollLabelView";
}

- (void)setSubviews {
    
    [self addWith:TXScrollLabelViewTypeLeftRight velocity:1 isArray:_isArray];
    
    [self addWith:TXScrollLabelViewTypeUpDown velocity:2 isArray:_isArray];
    
    [self addWith:TXScrollLabelViewTypeFlipRepeat velocity:2 isArray:_isArray];
    
    [self addWith:TXScrollLabelViewTypeFlipNoRepeat velocity:2 isArray:_isArray];
}

- (void)addWith:(TXScrollLabelViewType)type velocity:(CGFloat)velocity isArray:(BOOL)isArray {
    /** Step1: 滚动文字 */
    
    NSString *scrollTitle = @"如果在";
    
    NSArray *scrollTexts = @[@"If you need help or ask general question,",
                             @"just @tingxins in Weibo or Twitter, ofcourse, you can follow me. Welcome access to my blog.",
                             @"If you found a bug, just open an issue.",
                             @"If you have a feature request, just open an issue.",
                             @"If you want to contribute, fork this repository, and then submit a pull request.",
                             @"Blog : https://tingxins.com",
                             @"简书 ：http://www.jianshu.com/u/5141561e4d59",
                             @"GitHub : https://github.com/tingxins",
                             @"Weibo : http://weibo.com/tingxins",
                             @"Twitter : http://twitter.com/tingxins"];
    
    /** Step2: 创建 ScrollLabelView */
    TXScrollLabelView *scrollLabelView = nil;
    if (isArray) {
        scrollLabelView = [TXScrollLabelView scrollWithTextArray:scrollTexts type:type velocity:velocity options:UIViewAnimationOptionCurveEaseInOut inset:UIEdgeInsetsZero];
    }else {
        scrollLabelView = [TXScrollLabelView scrollWithTitle:scrollTitle type:type velocity:velocity options:UIViewAnimationOptionCurveEaseInOut];
    }
    
    /** Step3: 设置代理进行回调 */
    scrollLabelView.scrollLabelViewDelegate = self;
    
    /** Step4: 布局(Required) */
    scrollLabelView.frame = CGRectMake(50, 100 * (type + 0.7), 300, 30);
    
    [self.view addSubview:scrollLabelView];
    
    //偏好(Optional), Preference,if you want.
    scrollLabelView.tx_centerX  = [UIScreen mainScreen].bounds.size.width * 0.5;
    scrollLabelView.scrollInset = UIEdgeInsetsMake(0, 10 , 0, 10);
    scrollLabelView.scrollSpace = 10;
    scrollLabelView.font = [UIFont systemFontOfSize:15];
    scrollLabelView.textAlignment = NSTextAlignmentCenter;
    scrollLabelView.backgroundColor = [UIColor blackColor];
    scrollLabelView.layer.cornerRadius = 5;
    
    /** Step5: 开始滚动(Start scrolling!) */
    [scrollLabelView beginScrolling];
}

- (void)scrollLabelView:(TXScrollLabelView *)scrollLabelView didClickWithText:(NSString *)text atIndex:(NSInteger)index{
    NSLog(@"%@--%ld",text, index);
}
#pragma mark-button
- (void)actionBtn{
    
    ///连续两次present返回到第一个控制器
//    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
    
//    ///先push然后再present，返回到第一个控制器(presentedViewController当前控制器，presentingViewController上一个控制器)
//    UINavigationController * vc = self.presentationController.presentingViewController ;
//    NSLog(@"class = %@",NSStringFromClass(vc.class));
//    //有dismiss动画（和dismissViewControllerAnimated后面的bool值有关），放在外面有动画不会出现中间页面
//     [vc popViewControllerAnimated:NO];
//    [self dismissViewControllerAnimated:YES completion:^{
//        ///没有dismiss动画，放在里面有动画会出现中间页面
////       [vc popViewControllerAnimated:NO];
//    }];
    
    ///连续两次push返回到第一个控制器
    [self.navigationController popToViewController:self.navigationController.viewControllers.firstObject animated:YES];
    
    
//    [self.view addSubview:self.image];
//    [self showPickView];
}


- (UIImageView *)image{
    if (!_image) {
        _image = [UIImageView new];
        _image.frame = CGRectMake(100, 100, 200, 250);
        _image.image = [UIImage imageNamed:@"rp"];
        _image.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyBoard)];
        tapGesture.numberOfTouchesRequired=1;
        tapGesture.numberOfTapsRequired=1;
        tapGesture.delegate = self;
        [_image addGestureRecognizer:tapGesture];
        
//        UIControl *dummyControl = [[UIControl alloc] initWithFrame:self.view.bounds];
//        dummyControl.backgroundColor = [UIColor clearColor];
//        [dummyControl addTarget:self action:@selector(onTap:) forControlEvents:UIControlEventTouchUpInside];
//        [_image insertSubview:dummyControl atIndex:0];
        
        UIButton *btn = [UIButton new];
        btn.frame = CGRectMake(100, 100, 220, 50);
        btn.backgroundColor = [UIColor orangeColor];
        btn.titleLabel.text = @"123";
        [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(onTap:) forControlEvents:(UIControlEventTouchUpInside)];
//        [_image addSubview:btn];
    }
    return _image;
}

-(void)dismissKeyBoard{
    
//    [self.tableView endEditing:YES];
    NSLog(@"%@~~~~~~~~~",NSStringFromSelector(_cmd));
    [self hidePickView];
    
}

- (void)onTap:(UIControl *)sender
{
    NSLog(@"%@~~~~~~~~~",NSStringFromSelector(_cmd));
}


#pragma mark private methods
- (void)showPickView{
//    [UIView animateWithDuration:0.5 animations:^{
//        self.image.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    } completion:^(BOOL finished) {
//
//    }];
    
    self.image.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.0, 0.0);
    [UIView animateWithDuration:kTransformPart1AnimationDuration animations:^{
//        containerView.alpha = 1;
        self.image.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.2 animations:^{
//            containerView.alpha = 1;
            self.image.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 0.8);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:kTransformPart1AnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//                containerView.alpha = 1;
                self.image.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
            } completion:^(BOOL finished2) {
//                self.image.layer.shouldRasterize = NO;
            }];
            
        }];
    }];
    
}


- (void)hidePickView{

    [self.image removeFromSuperview];
    self.image = nil;
//    [UIView animateWithDuration:0.5 animations:^{
//        self.image.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
//    } completion:^(BOOL finished) {
////        [self.image removeFromSuperview];
//    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
