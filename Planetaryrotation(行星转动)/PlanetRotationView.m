//
//  PlanetRotationView.m
//  testbutton
//
//  Created by lmcqc on 2020/11/24.
//  Copyright © 2020 大碗豆. All rights reserved.
//

#import "PlanetRotationView.h"
#import "PRpoint.h"
#import "UIView+PRpointView.h"

typedef NS_ENUM(NSInteger, GestureRecognizerDirection) {
    GestureRecognizerLeft, //左
    GestureRecognizerRight, //右
};

@interface PlanetRotationView ()

@property (nonatomic, strong) NSMutableArray *arrayPoints;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSTimeInterval rotaduration;
@property (nonatomic, assign) BOOL isGesture;
@property(nonatomic, assign) GestureRecognizerDirection spanDirection;

@end

@implementation PlanetRotationView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        panRecognizer.minimumNumberOfTouches = 1;
        [self addGestureRecognizer:panRecognizer];
        self.spanDirection = GestureRecognizerLeft;
        self.rotaduration = 2;
        self.tiltAngle = 0.5;
    }
    return self;
}

- (void)setTiltAngle:(CGFloat)tiltAngle{
    _tiltAngle = tiltAngle;
}
- (void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    self.arrayPoints = [[NSMutableArray alloc] init];
     
    CGFloat angle = 1.0 * 360/dataSource.count;
     CGFloat radius = self.frame.size.width * 0.5;
     CGPoint orignalP = CGPointMake(radius - 10, radius);
    for (NSInteger i = 0; i < dataSource.count; i ++) {
        
//        UIView *tmpView = [[UIView alloc] init];
        UIImageView *tmpView = [[UIImageView alloc] init];
        tmpView.bounds = CGRectMake(0, 0, 100, 100);
        tmpView.image = [UIImage imageNamed:dataSource[i]];
        //添加单击手势
        UITapGestureRecognizer *tapGesture1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesAction:)];
        tapGesture1.numberOfTouchesRequired=1;
        tapGesture1.numberOfTapsRequired=1;
        tmpView.userInteractionEnabled = YES;
        [tmpView addGestureRecognizer:tapGesture1];
        
        CGPoint pot = [self calcCircleCoordinateWithCenter:orignalP andWithAngle:angle * i andWithRadius:radius];
        tmpView.center = CGPointMake(pot.x + 10, pot.y * self.tiltAngle);
        
        tmpView.tag = i;
        tmpView.viewFlag = [NSString stringWithFormat:@"%zd",i];
        
        PRpoint *tmpPoint = [[PRpoint alloc] init];
        tmpPoint.pCenter = tmpView.center;
        tmpPoint.pTag = i;
        [self.arrayPoints addObject:tmpPoint];
        
        [self addSubview:tmpView];
    }
     [self timerStart];
}

#pragma mark - 图片点击事件
- (void)tapGesAction:(UITapGestureRecognizer *)reg{
    NSLog(@"%@~~~~~~~~~",reg.view.viewFlag);
    if (self.prActionTapBlcok) {
        self.prActionTapBlcok([reg.view.viewFlag integerValue]);
    }
}

-(void)changeView{
    NSArray *subviews = self.subviews;
    for (int i=0; i<subviews.count; i++) {
        UIView *view = [subviews objectAtIndex:i];
        NSInteger index = view.tag;
        if (self.spanDirection == GestureRecognizerRight) {
            if (index == self.arrayPoints.count - 1) {
                index = 0;
            }else{
                index = view.tag + 1;
            }
        }else{
            if (index == 0) {
                index = self.arrayPoints.count - 1;
            }else{
                index = view.tag - 1;
            }
        }
        
        PRpoint *tmpP = self.arrayPoints[index];
        view.tag = tmpP.pTag;
        if (self.isGesture) {
            view.center = tmpP.pCenter;
            view.transform = CGAffineTransformMakeScale(index * 0.1 + 0.1, index * 0.1 + 0.1);
        }else{
            [UIView animateWithDuration:2.0 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                view.center = tmpP.pCenter;
                view.transform = CGAffineTransformMakeScale(index * 0.1 + 0.1, index * 0.1 + 0.1);
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)panRecognizer {
    CGPoint velocity = [panRecognizer velocityInView:panRecognizer.view];
    if(velocity.x>0){
        NSLog(@"向右滑动");
        self.spanDirection = GestureRecognizerRight;
    }else{
        NSLog(@"向左滑动");
        self.spanDirection = GestureRecognizerLeft;
    }
    
    switch (panRecognizer.state) {
        case UIGestureRecognizerStateBegan:
//            originalLocationInView = [panRecognizer locationInView:self];
//            previousLocationInView = originalLocationInView;
            break;
        case UIGestureRecognizerStateChanged: {
            [self timerStop];
            self.isGesture = YES;
          
            for (UIView *subView in self.subviews) {
                [subView.layer removeAllAnimations];
            }
            [self changeView];
        }
            break;
        default:
        {
            self.isGesture = NO;
            [self timerStart];
            [self changeView];
        }
            break;
    }
}

-(void)timerStart{
    if (_timer.isValid) {
        [_timer invalidate];
    }
    self.timer=[NSTimer scheduledTimerWithTimeInterval:self.rotaduration * 0.5 target:self selector:@selector(changeView) userInfo:nil repeats:YES];
}

-(void)timerStop{
    if (_timer.isValid) {
        [_timer invalidate];
    }
}

-(CGPoint)calcCircleCoordinateWithCenter:(CGPoint)center  andWithAngle : (CGFloat) angle andWithRadius: (CGFloat) radius{
    CGFloat x2 = radius*cosf(angle*M_PI/180);
    CGFloat y2 = radius*sinf(angle*M_PI/180);
    return CGPointMake(center.x+x2, center.y-y2);
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
