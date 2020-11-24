//
//  UIView+PRpointView.m
//  testbutton
//
//  Created by lmcqc on 2020/11/24.
//  Copyright © 2020 大碗豆. All rights reserved.
//

#import "UIView+PRpointView.h"
#import <objc/runtime.h>

@implementation UIView (PRpointView)

static const char * UIViewName_Key = "UIViewName_Key";

- (void)setViewFlag:(NSString *)viewFlag {
    objc_setAssociatedObject(self, UIViewName_Key, viewFlag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString *)viewFlag {
    return objc_getAssociatedObject(self, UIViewName_Key);
}

@end
