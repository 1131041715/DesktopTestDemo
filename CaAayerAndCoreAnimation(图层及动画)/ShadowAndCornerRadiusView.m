//
//  ShadowAndCornerRadiusView.m
//  testbutton
//
//  Created by lmcqc on 2020/11/26.
//  Copyright © 2020 大碗豆. All rights reserved.
//

#import "ShadowAndCornerRadiusView.h"

#define PHOTO_HEIGHT 150

@interface ShadowAndCornerRadiusView ()

@property (nonatomic, strong)  CALayer *cuostomlayer;

@end

@implementation ShadowAndCornerRadiusView
- (id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event {
    id<CAAction> action = [super actionForLayer:layer forKey:event];
    NSLog(@"action for layer: %@, for key:%@ is %@", layer, event, action);
    return action;
}


#pragma mark 绘制图形、图像到图层，注意参数中的ctx是图层的图形上下文，其中绘图位置也是相对图层而言的
-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    [super drawLayer:layer inContext:ctx];
    //    NSLog(@"%@",layer);//这个图层正是上面定义的图层
    CGContextSaveGState(ctx);

    //图形上下文形变，解决图片倒立的问题
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -PHOTO_HEIGHT);

    UIImage *image=[UIImage imageNamed:@"rp.png"];
    //注意这个位置是相对于图层而言的不是屏幕
    CGContextDrawImage(ctx, CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT), image.CGImage);

    //    CGContextFillRect(ctx, CGRectMake(0, 0, 100, 100));
    //    CGContextDrawPath(ctx, kCGPathFillStroke);

    CGContextRestoreGState(ctx);
}


- (void)drawRect:(CGRect)rect {
    CGPoint position= self.layer.position;
     CGRect bounds=CGRectMake(0, 0, PHOTO_HEIGHT, PHOTO_HEIGHT);
     CGFloat cornerRadius=PHOTO_HEIGHT/2;
     CGFloat borderWidth=2;
     
     //阴影图层
     CALayer *layerShadow=[[CALayer alloc]init];
     layerShadow.bounds=bounds;
     layerShadow.position=position;
     layerShadow.cornerRadius=cornerRadius;
     layerShadow.shadowColor=[UIColor grayColor].CGColor;
     layerShadow.shadowOffset=CGSizeMake(2, 1);
     layerShadow.shadowOpacity=1;
     layerShadow.borderColor=[UIColor whiteColor].CGColor;
     layerShadow.borderWidth=borderWidth;
     [self.layer addSublayer:layerShadow];
     
     //容器图层
     CALayer *cuostomlayer=[[CALayer alloc]init];
     cuostomlayer.bounds=bounds;
     cuostomlayer.position=position;
     cuostomlayer.backgroundColor=[UIColor redColor].CGColor;
     cuostomlayer.cornerRadius=cornerRadius;
     cuostomlayer.masksToBounds=YES;
     cuostomlayer.borderColor=[UIColor whiteColor].CGColor;
     cuostomlayer.borderWidth=borderWidth;

     //设置图层代理
//     cuostomlayer.delegate=self;

     //添加图层到根图层
     [self.layer addSublayer:cuostomlayer];
     
     //调用图层setNeedDisplay,否则代理方法不会被调用
//     [layer setNeedsDisplay];
     self.cuostomlayer = cuostomlayer;
    
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *result = [super hitTest:point withEvent:event];
    
    //判断 点（CGPoint）是否在某个范围（CGRect）内
    if (CGRectContainsPoint(self.cuostomlayer.frame, point)) {
        NSLog(@"点击的是cuostomlayer");
    }
    return result;
}
@end
