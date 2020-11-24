//
//  CoreAnimationVC.m
//  testbutton
//
//  Created by lmcqc on 2020/11/20.
//  Copyright © 2020 大碗豆. All rights reserved.
//

#import "CoreAnimationVC.h"
#import "PictureView.h"
#import "transform3DRotate.h"

@interface CoreAnimationVC ()
{
    UIImageView *_bgImgV;
    CGFloat _angle;
    UIView *oneView;
    UIView *middleView;
    UIView *bigView;
    CADisplayLink   *_displayLink;
}

@end

@implementation CoreAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateGrooveLayer)];
//    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//    _displayLink.paused = NO;
    
    
    // Do any additional setup after loading the view from its nib.
//    PictureView *pathView = [[PictureView alloc] initWithFrame:CGRectMake(20, 100, kScreenWidth - 20 * 2, 400)];
//    pathView.backgroundColor = [UIColor orangeColor];
//
//    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
//    [pathView addSubview:imgV];
//    imgV.image = [UIImage imageNamed:@"rp"];
//
//    UIImageView *imgV1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 90, 10, 10)];
//    [self.view addSubview:imgV1];
//    imgV1.image = [UIImage imageNamed:@"rp"];
//
//    [self.view addSubview:pathView];
    
    
//    [self createSubviews];
    
    [self startAnimation];
    
//    PictureView *circle = [[PictureView alloc] initWithFrame:CGRectMake(10,100, 320, 300)];
//    [circle setDiyAnimationBackgroundColor:[UIColor orangeColor]];
//    [self.view addSubview:circle];
//    CATransform3D trans = CATransform3DIdentity;
//    //    trans.m34 = -1/100.0;
//    trans = CATransform3DRotate(trans, M_PI/3, 1, 0, 0);
//    circle.layer.transform =trans;
    
    transform3DRotate *circle3D = [[transform3DRotate alloc] initWithFrame:CGRectMake(10,100, 320, 300)];
    circle3D.backgroundColor = [UIColor cyanColor];
//    [self.view addSubview:circle3D];
    
//    CATransform3D trans = CATransform3DIdentity;
////    trans.m34 = -1.0f/800.0;
//    trans = CATransform3DRotate(trans, M_PI/3, 1, 0, 0);
//    circle3D.layer.transform =trans;
    
    
    UIImageView *imgV2 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
    [circle3D addSubview:imgV2];
    imgV2.image = [UIImage imageNamed:@"rp"];
    
    // 创建一个基础动画
    CABasicAnimation *animation = [CABasicAnimation new];
    // 设置动画要改变的属性
    animation.keyPath = @"transform.rotation.z";
    animation.fromValue = @(0);
    // 动画的最终属性的值（转7.5圈）
    animation.toValue = @(M_PI*2);
    // 动画的播放时间
    animation.duration = 10;
    // 动画效果慢进慢出
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    // 解决动画结束后回到原始状态的问题
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount =MAXFLOAT;
    // 将动画添加到视图bgImgV的layer上
    [imgV2.layer addAnimation:animation forKey:@"rotation"];
    
    [circle3D createCircle: 0 andEndAngle:0 + 2 *M_PI];
    
    [circle3D createCircle: 46 * M_PI/180 andEndAngle:46 * M_PI/180 + 2 *M_PI];
    
    [circle3D createCircle: 80 * M_PI/180 andEndAngle:80 * M_PI/180 + 2 *M_PI];
    
    [circle3D createCircle: 200 * M_PI/180 andEndAngle:200 * M_PI/180 + 2 *M_PI];

   
//    [self test3D];
}

- (void)updateGrooveLayer{
    NSLog(@"~~~~~");
}



-(void)test3D{
    self.view.backgroundColor = [UIColor blackColor];
        
        bigView = [[UIView alloc] initWithFrame:CGRectMake(20, 160, 335, 335)];
    //    bigView.backgroundColor = [UIColor orangeColor];
        bigView.layer.borderWidth = 1;
        bigView.layer.borderColor = [UIColor colorWithWhite:1.000 alpha:0.200].CGColor;
        bigView.layer.cornerRadius = 167.5;
        [self.view addSubview:bigView];
    
    CATransform3D trans = CATransform3DIdentity;
    //    trans.m34 = -1/100.0;
        trans = CATransform3DRotate(trans, M_PI/2, 1, 0, 0);
        bigView.layer.transform =trans;
        
//        [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(taiji2) userInfo:nil repeats:YES];
        
        
        UIView *bigView1 = [[UIView alloc] initWithFrame:CGRectMake(317.5, 150, 35, 35)];
        bigView1.backgroundColor = [UIColor colorWithRed:0.844 green:0.872 blue:0.610 alpha:1.000];
        bigView1.layer.cornerRadius = 17.5;
        [bigView addSubview:bigView1];
  

        
        middleView = [[UIView alloc] initWithFrame:CGRectMake(42.5, 42.5, 250, 250)];
    //    middleView.backgroundColor = [UIColor yellowColor];
        middleView.layer.borderWidth = 1;
        middleView.layer.borderColor = [UIColor colorWithWhite:1.000 alpha:0.200].CGColor;
        middleView.layer.cornerRadius = 125.5;
        [bigView addSubview:middleView];
       
        [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(taiji1) userInfo:nil repeats:YES];
        
        
        UIView *middleView1 = [[UIView alloc] initWithFrame:CGRectMake(232.5, 107.5, 35, 35)];
        middleView1.backgroundColor = [UIColor colorWithRed:0.689 green:0.624 blue:0.632 alpha:1.000];
        middleView1.layer.cornerRadius = 17.5;
        [middleView addSubview:middleView1];
      
        
        
        oneView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 150, 150)];
    //    oneView.backgroundColor = [UIColor cyanColor];
        oneView.layer.borderWidth = 1;
        oneView.layer.borderColor = [UIColor colorWithWhite:1.000 alpha:0.200].CGColor;
        oneView.layer.cornerRadius = 75;
        [middleView addSubview:oneView];
        
        [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(taiji) userInfo:nil repeats:YES];
        
        
        
        UIView *smillView = [[UIView alloc] initWithFrame:CGRectMake(130, 55, 40, 40)];
        smillView.backgroundColor = [UIColor colorWithRed:0.758 green:0.714 blue:0.535 alpha:1.000];
        smillView.layer.cornerRadius = 20;
        [oneView addSubview:smillView];
        
        
        UIView *centreView = [[UIView alloc] initWithFrame:CGRectMake(45, 45, 60, 60)];
        centreView.backgroundColor = [UIColor colorWithRed:0.600 green:0.400 blue:0.200 alpha:0.220];
        centreView.layer.cornerRadius = 30;
        [oneView addSubview:centreView];
       
}

//oneView转
- (void)taiji {
    [UIView animateWithDuration:3 delay:0 options:(UIViewAnimationOptionCurveLinear) animations:^{
        self->oneView.transform = CGAffineTransformRotate(self->oneView.transform, M_PI_4);
    } completion:^(BOOL finished) {
    }];
}


//middleView转
- (void)taiji1 {
    [UIView animateWithDuration:3 delay:0 options:(UIViewAnimationOptionCurveLinear) animations:^{
        self->middleView.transform = CGAffineTransformRotate(self->oneView.transform, M_PI_4);
    } completion:^(BOOL finished) {
    }];
}

//middleView转
- (void)taiji2 {
    [UIView animateWithDuration:3 delay:0 options:(UIViewAnimationOptionCurveLinear) animations:^{
        self->bigView.transform = CGAffineTransformRotate(self->oneView.transform, M_PI_4);
    } completion:^(BOOL finished) {
    }];
}



-(void)startAnimation
{
    
        UIImageView *imgV1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 90, 10, 10)];
        [self.view addSubview:imgV1];
        imgV1.image = [UIImage imageNamed:@"rp"];
////    方法一 用法1​ Value方式
//    //创建动画对象
//
//    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//
//    //设置value
//
//    NSValue *value1=[NSValue valueWithCGPoint:CGPointMake(100, 100)];
//
//    NSValue *value2=[NSValue valueWithCGPoint:CGPointMake(200, 100)];
//
//    NSValue *value3=[NSValue valueWithCGPoint:CGPointMake(200, 200)];
//
//    NSValue *value4=[NSValue valueWithCGPoint:CGPointMake(100, 200)];
//
//    NSValue *value5=[NSValue valueWithCGPoint:CGPointMake(100, 300)];
//
//    NSValue *value6=[NSValue valueWithCGPoint:CGPointMake(200, 400)];
//
//    animation.values=@[value1,value2,value3,value4,value5,value6];
//
//    //重复次数 默认为1
//
//    animation.repeatCount=MAXFLOAT;
//
//    //设置是否原路返回默认为不
//
//    animation.autoreverses = YES;
//
//    //设置移动速度，越小越快
//
//    animation.duration = 4.0f;
//
//    animation.removedOnCompletion = NO;
//
//    animation.fillMode = kCAFillModeForwards;
//
//    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//
////    animation.delegate=self;
//
//    //给这个view加上动画效果
//
//    [imgV1.layer addAnimation:animation forKey:nil];
    
    
    //    用法2​  Path方式
    
    //创建动画对象
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    //创建一个CGPathRef对象，就是动画的路线
    
    UIBezierPath *_circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 100, 100, 100)];
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    //自动沿着弧度移动
    
//    CGPathAddEllipseInRect(path, NULL, CGRectMake(150, 200, 100, 100));
    
    //设置开始位置
    
    CGPathMoveToPoint(path,NULL,100,100);
    
    //沿着直线移动
    
    CGPathAddLineToPoint(path,NULL, 200, 100);

    CGPathAddLineToPoint(path,NULL, 200, 200);

    CGPathAddLineToPoint(path,NULL, 100, 200);

    CGPathAddLineToPoint(path,NULL, 100, 300);

    CGPathAddLineToPoint(path,NULL, 200, 400);
//
//    //沿着曲线移动
//
//    CGPathAddCurveToPoint(path,NULL,50.0,275.0,150.0,275.0,70.0,120.0);
//
//    CGPathAddCurveToPoint(path,NULL,150.0,275.0,250.0,275.0,90.0,120.0);
//
//    CGPathAddCurveToPoint(path,NULL,250.0,275.0,350.0,275.0,110.0,120.0);
//
//    CGPathAddCurveToPoint(path,NULL,350.0,275.0,450.0,275.0,130.0,120.0);
    
    animation.path= path;
    
    CGPathRelease(path);
    
    animation.autoreverses = NO;
    
    animation.repeatCount=MAXFLOAT;
    
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    animation.duration = 4.0f;
    
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
//    animation.delegate=self;
    
    [imgV1.layer addAnimation:animation forKey:nil];
    

}

- (void)createSubviews{
     //NSArray *arr = @[@"10",@"20",@"40",@"50",@"60",@"80",@"100",@"140",@"200",@"300",@"400",@"500",@"1000",@"2000",@"10000"];
     NSArray *arr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
     // 背景图片
     UIImageView *bgImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
     bgImgV.layer.cornerRadius = bgImgV.frame.size.width/2;
     bgImgV.layer.masksToBounds = YES;
    bgImgV.center = self.view.center;
     bgImgV.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self.view addSubview:bgImgV];
     _bgImgV = bgImgV;
    
        CATransform3D trans = CATransform3DIdentity;
    //    trans.m34 = -1/100.0;
        trans = CATransform3DRotate(trans, M_PI/4, 1, 0, 0);
        bgImgV.layer.transform =trans;
     //
     NSInteger i = 0;
     // 圆的半径
     CGFloat r = bgImgV.frame.size.width/2;
     // 转盘每一扇形的角度
     CGFloat angle = M_PI/180 * 360/arr.count;
     _angle = angle;
     // 循环创建扇形上的数字
     for (NSString *str in arr) {

         UILabel *rewardMoneyLabel = [UILabel new];
         rewardMoneyLabel.frame = CGRectMake(r, 0, cos(angle/2) * r,2 * sin(angle/2) * r);
         rewardMoneyLabel.center = CGPointMake(rewardMoneyLabel.center.x,bgImgV.frame.size.height/2);
         rewardMoneyLabel.textAlignment = NSTextAlignmentRight;
         rewardMoneyLabel.backgroundColor = [UIColor orangeColor];
         rewardMoneyLabel.text = str;
         [bgImgV addSubview:rewardMoneyLabel];

         // 设置锚点（以视图上的哪一点为旋转中心，（0，0）是左下角，（1，1）是右上角，（0.5，0.5）是中心）
         rewardMoneyLabel.layer.anchorPoint = CGPointMake(0, 0.5);
         // 设置旋转的位置
         rewardMoneyLabel.layer.position = CGPointMake(r, r);
         // 旋转
         rewardMoneyLabel.transform = CGAffineTransformMakeRotation(angle * i);
         i ++ ;
     }

     //红色开始按钮
     UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
     startBtn.frame = CGRectMake(0, 0, 50, 50);
     startBtn.center = CGPointMake(r, r);
     startBtn.backgroundColor = [UIColor redColor];
     // 开始按钮点击事件
     [startBtn addTarget:self action:@selector(startBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
 }
 // 点击红色开始按钮事件
 - (void)startBtnAction:(UIButton*)sender{
     // 创建一个基础动画
     CABasicAnimation *animation = [CABasicAnimation new];
     // 设置动画要改变的属性
     animation.keyPath = @"transform.rotation.z";
     //animation.fromValue = @(_bgImgV.layer.transform.m11);
     // 动画的最终属性的值（转7.5圈）
     animation.toValue = @(M_PI*15);
     // 动画的播放时间
     animation.duration = 3;
     // 动画效果慢进慢出
     animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
     // 解决动画结束后回到原始状态的问题
     animation.removedOnCompletion = NO;
     animation.fillMode = kCAFillModeForwards;
     // 将动画添加到视图bgImgV的layer上
//     [_bgImgV.layer addAnimation:animation forKey:@"rotation"];


     // 其他两种旋转方法
     [UIView animateWithDuration:1 animations:^{
//         _bgImgV.transform = CGAffineTransformRotate(_bgImgV.transform, M_PI/180 + _angle);
     }];
     [UIView animateWithDuration:1 animations:^{
         _bgImgV.layer.transform = CATransform3DRotate(_bgImgV.layer.transform, _angle, 0, 0, 1);
     }];
 }
@end
