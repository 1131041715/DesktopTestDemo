//
//  PlanetaryrotationVC.m
//  testbutton
//
//  Created by lmcqc on 2020/11/24.
//  Copyright © 2020 大碗豆. All rights reserved.
//

#import "PlanetaryrotationVC.h"
#import "PlanetRotationView.h"


@interface PlanetaryrotationVC ()

@end

@implementation PlanetaryrotationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor blackColor];
    
    NSMutableArray *nameArr = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 10; i ++) {
        NSString *nameStr = [NSString stringWithFormat:@"%u_roat.png",arc4random_uniform(10)];
        [nameArr addObject:nameStr];
    }
    
    
    PlanetRotationView *prView = [[PlanetRotationView alloc] initWithFrame:CGRectMake(40, 150, kScreenWidth - 40 * 2, kScreenWidth - 40 * 2)];
    prView.backgroundColor = [UIColor blackColor];
    prView.transform = CGAffineTransformMakeScale(0.1,0.1);
    prView.center = CGPointMake(0, 0);
    
    [self.view addSubview:prView];
    [UIView animateWithDuration:3 animations:^{
        prView.center = CGPointMake(40 + (kScreenWidth - 40 * 2) * 0.5, 150 + (kScreenWidth - 40 * 2) * 0.5);
        prView.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        
    }];
    prView.tiltAngle = cos(M_PI/3);
    prView.dataSource = nameArr;
    
//    UIView *zzView = [[UIView alloc] init];
//    prView.name = @"leroy";
//    NSLog(@"the view name is : %@",prView.name);
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
