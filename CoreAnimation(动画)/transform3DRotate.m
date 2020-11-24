//
//  transform3DRotate.m
//  testbutton
//
//  Created by lmcqc on 2020/11/23.
//  Copyright © 2020 大碗豆. All rights reserved.
//

#import "transform3DRotate.h"

@implementation transform3DRotate

//创建环绕动画,传入两个个属性分别是 :运动开始的角度(右侧90度为0),运动结束的角度

-(void)createCircle:(float)startAngle andEndAngle:(float)endAngle{
    //创建运动的轨迹动画

    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];

    pathAnimation.calculationMode =kCAAnimationPaced;

    pathAnimation.fillMode =kCAFillModeForwards;

    pathAnimation.removedOnCompletion =NO;

    pathAnimation.duration =10.0;

    pathAnimation.repeatCount =MAXFLOAT;

    float x =30;

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
    
//    CATransform3D trans = CATransform3DIdentity;
//    //    trans.m34 = -1/100.0;
//    trans = CATransform3DRotate(trans, -M_PI/3, 1, 0, 0);
//    tmpLab.layer.transform =trans;
    
//    //缩放动画
    CABasicAnimation *anima4 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anima4.fromValue = [NSNumber numberWithFloat:0.8f];
    anima4.toValue = [NSNumber numberWithFloat:2.3f];
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

    circleView1.frame =CGRectMake(130,130, x, x);

//    [circleView1.layer setCornerRadius:x/2];

    circleView1.backgroundColor = [UIColor yellowColor];
    


    //设置运转的动画

    [circleView1.layer addAnimation:pathAnimation forKey:@"moveTheCircleOne"];
    
    NSLog(@"~~~%f",circleView1.layer.frame.origin.x);
    
    
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

-(void)gaintPoint{
    
}

#pragma mark 计算圆圈上点在IOS系统中的坐标
-(CGPoint) calcCircleCoordinateWithCenter:(CGPoint) center  andWithAngle : (CGFloat) angle andWithRadius: (CGFloat) radius{
    CGFloat x2 = radius*cosf(angle*M_PI/180);
    CGFloat y2 = radius*sinf(angle*M_PI/180);
    return CGPointMake(center.x+x2, center.y-y2);
}

@end
