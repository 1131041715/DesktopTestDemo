//
//  PlanetRotationView.h
//  testbutton
//
//  Created by lmcqc on 2020/11/24.
//  Copyright © 2020 大碗豆. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlanetRotationView : UIView

@property (nonatomic, strong) NSArray *dataSource;

/// 倾斜比例（根据倾斜角度计算投影比例  cos（角度0-90）相对于x轴）
@property (nonatomic, assign) CGFloat tiltAngle;

@property (nonatomic, strong) void (^prActionTapBlcok)(NSInteger tagView);
@end

NS_ASSUME_NONNULL_END
