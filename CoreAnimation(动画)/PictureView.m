//
//  PictureView.m
//  核心动画
//
//  Created by 金钱象 on 16/10/23.
//  Copyright © 2016年 zhonghuatianchuang. All rights reserved.
//

#import "PictureView.h"

@interface PictureView ()
{


}

@property(nonatomic,strong) UIBezierPath *path;

@end



@implementation PictureView


/**
 *  手指接触屏幕的点
 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //touch
    UITouch *touch = [touches anyObject];
    //获取手指的触摸点
    CGPoint pointCurrent = [touch locationInView:self];
    //创建路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //记录路径
    _path = path;
    
    //设置起点
    [path moveToPoint:pointCurrent];


}

/**
 *  手指一动的时候的点
 */
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //touch
    UITouch *touch = [touches anyObject];
    //获取手指的触摸点
    CGPoint pointCurrent = [touch locationInView:self];

    //保存每一个路径
    [_path addLineToPoint:pointCurrent];
    
    //每次一动就调用画画
    [self setNeedsDisplay];

}

/**
 *  画线
 */
-(void)drawRect:(CGRect)rect
{
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(130, 10, 100, 50)];
//    [path stroke];
    
    UIBezierPath *_circlePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
    [_circlePath moveToPoint:CGPointMake(100, 100)];
    [_circlePath stroke];
    
    
//    //创建动画
//    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
//
//    animation.keyPath = @"position";
//
//
//    animation.duration = 5;
//
//    animation.path = _circlePath.CGPath;
//
//    animation.repeatCount = MAXFLOAT;
//
//    animation.calculationMode = kCAAnimationPaced;
//
//    animation.timingFunctions = @[kCAMediaTimingFunctionEaseIn];
//
////    animation.timeOffset = 10;
//
//    animation.beginTime = 3;
//
//    //添加动画
//    [[[self.subviews firstObject] layer] addAnimation:animation forKey:@"round"];
//    [[[self.subviews lastObject] layer] addAnimation:animation forKey:nil];
    
//    CGFloat origin_x =self.frame.size.width/2;
//
//    CGFloat origin_y =self.frame.size.height/2;
//
//
//    CGContextRef context =UIGraphicsGetCurrentContext();
//
//    CGContextSaveGState(context);
//        //整个圆
//
//    UIBezierPath *arc = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(origin_x -100, origin_y - 100,200, 200)];
//
//    [[UIColor whiteColor] setStroke];
//
//    [arc stroke];
//
//    CGContextRestoreGState(context);
}


 //创建环绕动画,传入两个个属性分别是 :运动开始的角度(右侧90度为0),运动结束的角度

-(void)createCircle:(float)startAngle andEndAngle:(float)endAngle{
    //创建运动的轨迹动画

    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];

    pathAnimation.calculationMode =kCAAnimationPaced;

    pathAnimation.fillMode =kCAFillModeForwards;

    pathAnimation.removedOnCompletion =NO;

    pathAnimation.duration =10.0;

    pathAnimation.repeatCount =MAXFLOAT;

    

    float x =50;

    // (1 1)  绕z轴   (1 0) y   (0 1) x  (0 0) nil

    float radiuscaleOne = 1;

    float radiuscaleTwo = 1;

    // 中心

    CGFloat origin_x =self.frame.size.width /2  ;

    CGFloat origin_y =self.frame.size.height /2 ;

    // 半径

    CGFloat radiusX =80;

    CGMutablePathRef ovalfromarc =CGPathCreateMutable();

    CGAffineTransform t2 =CGAffineTransformConcat(CGAffineTransformConcat(CGAffineTransformMakeTranslation(-origin_x, -origin_y), CGAffineTransformMakeScale(radiuscaleOne, radiuscaleTwo)), CGAffineTransformMakeTranslation(origin_x, origin_y));

    CGPathAddArc(ovalfromarc, &t2, origin_x, origin_y, radiusX,startAngle,endAngle,0);// 1逆时针 0顺时针

    pathAnimation.path = ovalfromarc;

    CGPathRelease(ovalfromarc);

    // 圆形

    UIView * circleView1 = [[UIImageView alloc] init];
    
//        UIImageView *circleView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
//        [self addSubview:circleView1];
//        circleView1.image = [UIImage imageNamed:@"rp"];
    
    UILabel *tmpLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, x, x)];
    tmpLab.text = @"谁看";
    tmpLab.font = [UIFont systemFontOfSize:15];
    tmpLab.textColor = [UIColor blackColor];
    tmpLab.backgroundColor = [UIColor redColor];
    [circleView1 addSubview:tmpLab];
    
//    //缩放动画
    CABasicAnimation *anima4 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima4.fromValue = [NSNumber numberWithFloat:0.8f];
    anima4.toValue = [NSNumber numberWithFloat:1.3f];
    anima4.repeatCount =MAXFLOAT;
    anima4.duration =3;
//    anima4.calculationMode =kCAAnimationPaced;
    anima4.fillMode =kCAFillModeForwards;
    anima4.removedOnCompletion =NO;
    anima4.autoreverses = YES;
    [tmpLab.layer addAnimation:anima4 forKey:@"scale-layer"];
    
//    CABasicAnimation *anima5 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    anima5.fromValue = [NSNumber numberWithFloat:1.3f];
//    anima5.toValue = [NSNumber numberWithFloat:0.8f];
//    [tmpLab.layer addAnimation:anima5 forKey:@"scale-layer"];
    
    
//    [circleView1 addSubview:lab];
//        CATransform3D trans = CATransform3DIdentity;
////            trans.m34 = -1/100.0;
//        trans = CATransform3DRotate(trans, 0, 1, 0, 0);
//        circleView1.layer.transform =trans;
    
    
//    [UIView animateWithDuration:10 animations:^{
//           circleView1.layer.transform = trans;
//       }];
    
    [self addSubview:circleView1];

    circleView1.frame =CGRectMake(130,130, x-20, x);

//    [circleView1.layer setCornerRadius:x/2];

    circleView1.backgroundColor = [UIColor yellowColor];
    


    //设置运转的动画

    [circleView1.layer addAnimation:pathAnimation forKey:@"moveTheCircleOne"];
    
    
    //缩放动画
    CABasicAnimation *anima2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima2.fromValue = [NSNumber numberWithFloat:0.8f];
    anima2.toValue = [NSNumber numberWithFloat:1.3f];
    
//    CABasicAnimation *anima3 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    anima3.fromValue = [NSNumber numberWithFloat:2.0f];
//    anima3.toValue = [NSNumber numberWithFloat:0.8f];
    
    //组动画
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = [NSArray arrayWithObjects:pathAnimation,anima2, nil];
//    groupAnimation.duration = 4.0f;
    groupAnimation.duration =10;

    groupAnimation.repeatCount =MAXFLOAT;
    
//    groupAnimation.calculationMode =kCAAnimationPaced;

    groupAnimation.fillMode =kCAFillModeBoth;
    groupAnimation.autoreverses = NO;

    groupAnimation.removedOnCompletion =NO;
//    groupAnimation.speed = 0.5;
    
//    [circleView1.layer addAnimation:groupAnimation forKey:@"groupAnimation"];


}

 -(void)setDiyAnimationBackgroundColor:(UIColor *)aColor

{

    self.backgroundColor = aColor;

//    [self createCircle: M_PI /6 andEndAngle:M_PI /6 + 2 *M_PI];
    
    [self createCircle: 0 andEndAngle:0 + 2 *M_PI];
    
    [self createCircle: 46 * M_PI/180 andEndAngle:46 * M_PI/180 + 2 *M_PI];
    
    [self createCircle: 80 * M_PI/180 andEndAngle:80 * M_PI/180 + 2 *M_PI];
    
    [self createCircle: 200 * M_PI/180 andEndAngle:200 * M_PI/180 + 2 *M_PI];
    
    
}

/**
 *  手指抬起来的时候
 */
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    //创建动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    
    animation.keyPath = @"position";
    
    animation.duration = 2;
    
    animation.path = _path.CGPath;
    
    animation.repeatCount = MAXFLOAT;
    
    //添加动画
    [[[self.subviews firstObject] layer] addAnimation:animation forKey:nil];
//    [[[self.subviews lastObject] layer] addAnimation:animation forKey:nil];
    
}




@end
