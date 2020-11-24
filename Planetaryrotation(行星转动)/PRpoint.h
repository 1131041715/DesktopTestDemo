//
//  PRpoint.h
//  testbutton
//
//  Created by lmcqc on 2020/11/24.
//  Copyright © 2020 大碗豆. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

struct PFPoint {
    CGFloat x;
    CGFloat y;
    CGFloat z;
};

@interface PRpoint : NSObject

@property (nonatomic, assign) struct PFPoint typepoint;

//@property (nonatomic, assign) CGFloat xp;
//
//@property (nonatomic, assign) CGFloat yp;

@property (nonatomic, assign) CGPoint pCenter;

//@property (nonatomic, assign) CGPoint TransformMakeScale;


@property (nonatomic, assign) NSInteger pTag;
@end


