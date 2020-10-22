//
//  ViewController.m
//  testbutton
//
//  Created by 大碗豆 on 17/4/11.
//  Copyright © 2017年 大碗豆. All rights reserved.
//

#import "ViewController.h"
#import "EFButton.h"
#import "LGAlertView.h"
#import "alertviewViewController.h"
#import "imagePickerViewController.h"
#import "EGmyAlertView.h"
#import "YFGIFImageView.h"
#import "QWERT.h"
#import "MJExtension.h"

#import "ScrawlViewController.h"



#import "HLWebViewController.h"

#import "alertviewViewController.h"


#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,LGAlertViewDelegate,UITextViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextFieldDelegate>

@property(nonatomic,strong)UIViewController *vc;

@property(nonatomic,strong)alertviewViewController *alertVC;

@property(nonatomic,strong) imagePickerViewController *imagePickVC;


@property(nonatomic,strong)NSString *是;

@property(nonatomic,strong)UITextView *textView;

@property(nonatomic,strong)NSDictionary *dic;

@property(nonatomic,strong)UIImageView *imag;

@property (nonatomic,assign) NSInteger tmpFlag;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) NSArray *controlArr;

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _dic = [NSDictionary new];
    
    EFButton *btn = [EFButton new];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(100, 600, 140, 60);
//    btn.center = CGPointMake(100, 100);
    [btn setTitle:@"客服服务" forState:(UIControlStateNormal)];
    [btn setImage:[UIImage imageNamed:@"qwas.png"] forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
    self.tmpFlag = 0;
//    btn.center = CGPointMake(200, 200);
//    btn.transform = CGAffineTransformMakeRotation(-71.565051);
    
//    UIView *tmpView = [[UIView alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
//    tmpView.backgroundColor = [UIColor purpleColor];
//    [self.view addSubview:tmpView];
//
//    tmpView.transform = CGAffineTransformMakeRotation(-70);
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArr = @[@"数组字符串数据处理",@"动态方法调用",@"车牌键盘",@"加载转圈",@"历史记录展示",@"图片浏览",@"label搜索条件展示",@"不限制内容弹窗提示",@"tab弹窗单选",@"keep动画",@"日历自定义",@"控制连续跳转返回",@"文字滚动"];
    self.controlArr = @[@"ArrayHandelVC",@"DynamicMethodVC",@"LicensePlateVC",@"LoadingViewVC",@"HistoryVC",@"ImagebrowseVC",@"SelectLabelShowVC",@"ANPopoverVC",@"TabAloneSelectVC",@"KeepLaunchAnimationVC",@"CalendarCustomVC",@"alertviewViewController",@"LabelScrlllVC"];
    self.title = @"首页";
    [self.view addSubview:self.tableView];
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",(long)indexPath.row);
    
    NSString *titleName = self.dataArr[indexPath.row];
    NSString *VCName = self.controlArr[indexPath.row];
    Class contrName = NSClassFromString(VCName);
    UIViewController *VC = [[contrName alloc] init];
    VC.title = titleName;
    [self.navigationController pushViewController:VC animated:YES];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = ({
            UITableView *tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - STATUS_NAV_HEIGHT - TABBAR_SPACE) style:(UITableViewStylePlain)];
            tab.rowHeight = 50;
            tab.dataSource = self;
            tab.delegate = self;
            tab.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
            tab.backgroundColor = [UIColor whiteColor];
            tab.separatorStyle = UITableViewCellSeparatorStyleNone;
            tab;
        });
    }
    return _tableView;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:NSStringFromClass([self class])];
    }
    cell.backgroundColor = ANYColorRandom;
    NSString *titleName = self.dataArr[indexPath.row];
    NSString *VCName = self.controlArr[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@~~%@",titleName,VCName];
    return cell;
}

-(void)click:(UIButton *)btn{
    btn.selected = !btn.selected;

}






- (imagePickerViewController *)imagePickVC{
    if (!_imagePickVC) {
        _imagePickVC = [imagePickerViewController new];
    }
    return _imagePickVC;
}


- (alertviewViewController *)alertVC{
    if (!_alertVC) {
        _alertVC = [alertviewViewController new];
        _alertVC.view.frame = CGRectMake(0, 0, 200, 200);
    }
    return _alertVC;
}





#pragma mark - icon旋转
- (void)imagRotate:(UIButton *)btn{
    if (self.tmpFlag > 7) {
        self.tmpFlag = 0;
    }
    //    double aaa = atan(-1);
    //    double asina = sin(M_PI/6);
    //    NSLog(@"%f ~~~~ %f~~~~%f",aaa,asina,M_PI);
    
    //    double angle1 = [self getBearingWithLat1:5 whitLng1:4 whitLat2:6 whitLng2:5];
    //    double angle2 = [self getBearingWithLat1:5 whitLng1:4 whitLat2:6 whitLng2:3];
    //    double angle3 = [self getBearingWithLat1:5 whitLng1:4 whitLat2:4 whitLng2:3];
    //    double angle4 = [self getBearingWithLat1:5 whitLng1:4 whitLat2:4 whitLng2:5];
    //    NSLog(@"第一象限%f~~~第二象限%f~~~~第三象限%f~~~~第四象限%f",angle1,angle2,angle3,angle4);
    
    //    double angle1 = [self getTanWithLat1:5 whitLng1:4 whitLat2:6 whitLng2:5];
    //    double angle2 = [self getTanWithLat1:5 whitLng1:4 whitLat2:6 whitLng2:3];
    //    double angle3 = [self getTanWithLat1:5 whitLng1:4 whitLat2:4 whitLng2:3];
    //    double angle4 = [self getTanWithLat1:5 whitLng1:4 whitLat2:4 whitLng2:5];
    //    NSLog(@"第一象限%f~~~第二象限%f~~~~第三象限%f~~~~第四象限%f",angle1,angle2,angle3,angle4);
    
    switch (self.tmpFlag) {
        case 0:
        {
            double angle1 = [self getTanWithLat1:5 whitLng1:4 whitLat2:8 whitLng2:5];
            NSLog(@"第一象限%f",angle1);
            btn.transform = CGAffineTransformMakeRotation(angle1);
        }
            break;
        case 1:
        {
            double angle2 = [self getTanWithLat1:5 whitLng1:4 whitLat2:6 whitLng2:3];
            NSLog(@"第二象限%f",angle2);
            btn.transform = CGAffineTransformMakeRotation(angle2);
        }
            break;
        case 2:
        {
            double angle3 = [self getTanWithLat1:5 whitLng1:4 whitLat2:4 whitLng2:3];
            NSLog(@"第三象限%f",angle3);
            btn.transform = CGAffineTransformMakeRotation(angle3);
        }
            break;
        case 3:
        {
            double angle4 = [self getTanWithLat1:5 whitLng1:4 whitLat2:4 whitLng2:5];
            NSLog(@"第四象限%f",angle4);
            btn.transform = CGAffineTransformMakeRotation(angle4);
        }
            break;
        case 4:
        {
            double angle4 = [self getTanWithLat1:5 whitLng1:4 whitLat2:6 whitLng2:4];
            NSLog(@"y上半轴%f",angle4);
            btn.transform = CGAffineTransformMakeRotation(angle4);
        }
            break;
        case 5:
        {
            double angle4 = [self getTanWithLat1:5 whitLng1:4 whitLat2:4 whitLng2:4];
            NSLog(@"y下半轴%f",angle4);
            btn.transform = CGAffineTransformMakeRotation(angle4);
        }
            break;
        case 6:
        {
            double angle4 = [self getTanWithLat1:5 whitLng1:4 whitLat2:5 whitLng2:5];
            NSLog(@"x右半轴%f",angle4);
            btn.transform = CGAffineTransformMakeRotation(angle4);
        }
            break;
            
        case 7:
        {
            double angle4 = [self getTanWithLat1:5 whitLng1:4 whitLat2:5 whitLng2:3];
            NSLog(@"x左半轴%f",angle4);
            btn.transform = CGAffineTransformMakeRotation(angle4);
        }
            break;
            
        default:
            break;
    }
    self.tmpFlag += 1;
}









//使用tan计算两点之间的转角
-(double)getTanWithLat1:(double)latY1 whitLng1:(double)lngX1 whitLat2:(double)latY2 whitLng2:(double)lngX2{
    
    if (latY1 == latY2 && lngX1 == lngX2) {
        return 0;
    }
    
    //y轴点
    if (lngX2 == lngX1) {
        if (latY2 > latY1) {
            return -90;
        }else{
            return 90;
        }
    }
    //x轴点
    if (latY2 == latY1) {
        if (lngX2 > lngX1) {
            return 0;
        }else{
            return 180;
        }
    }
    
    double d = 0;
    //绝对值
    double fabs(double d);
    double X = fabs(lngX2 - lngX1);
    double Y = fabs(latY2 - latY1);
    double radian = atan(Y * 1.0 / X);
    double angle = [self angle:radian];
    d = angle;
    
    if (latY2 > latY1) {
        if (lngX2 > lngX1) {
            return -d;
        }else{
            return d - 180;
        }
    }else{
        if (lngX2 > lngX1) {
            return d;
        }else{
            return 180 - d;
        }
    }
    return d;
}

//两个经纬度之间的角度
-(double)getBearingWithLat1:(double)lat1 whitLng1:(double)lng1 whitLat2:(double)lat2 whitLng2:(double)lng2{
    
    double d = 0;
    double radLat1 =  [self radian:lat1];
    double radLat2 =  [self radian:lat2];
    double radLng1 = [self radian:lng1];
    double radLng2 =  [self radian:lng2];
    d = sin(radLat1)*sin(radLat2)+cos(radLat1)*cos(radLat2)*cos(radLng2-radLng1);
    d = sqrt(1-d*d);
    d = cos(radLat2)*sin(radLng2-radLng1)/d;
    d = [self angle:asin(d)];
//    double fabs(double d);
//    d = fabs(d);
    //    if(lat2 < lat1){
    //        d = 180-d;
    //    }
    return d;
}
//根据角度计算弧度
-(double)radian:(double)d{
    return d * M_PI/180.0;
}
//根据弧度计算角度
-(double)angle:(double)r{
    return r * 180/M_PI;
}
#pragma mark - 使用uiview创建image
- (void)convertCreateImageWithUIView:(UIView *)view{
    UIView *tmpView = [[UIView alloc] initWithFrame:CGRectMake(200, 100, 100, 100)];
    tmpView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:tmpView];
    
    UIImageView *imag = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
    imag.image = [UIImage imageNamed:@"rp"];
    [tmpView addSubview:imag];
    self.imag = imag;
    self.imag.transform = CGAffineTransformMakeRotation(223);
    
    UIImageView *imag1 = [[UIImageView alloc] initWithFrame:CGRectMake(200, 300, 100, 100)];
    imag1.image = [UIImage imageNamed:@"rp"];
    [self.view addSubview:imag1];
    
    UIGraphicsBeginImageContextWithOptions(tmpView.bounds.size, NO, [UIScreen mainScreen].scale);
    [tmpView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    imag1.image = viewImage;
}




#pragma mark UIAlertAction颜色修改

- (void)callNumber{
    
    //    方法一:不弹出提示直接拨打
    NSMutableString *str=[[NSMutableString alloc]initWithFormat:@"tel:%@",@"113"];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    //    方法二:会弹出提示
    
    NSMutableString *str1=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"332"];
    
    UIWebView *callWebview = [[UIWebView alloc]init];
    
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str1]]];
    
    [self.view addSubview:callWebview];
    
    //    方法三:会弹出提示
    
    NSMutableString* str2=[[NSMutableString alloc]initWithFormat:@"telprompt://%@",@"111"];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str2]];
    
//    方案四之终极拨号方式:
    
    NSMutableString *str3 = [[NSMutableString alloc]initWithFormat:@"tel:%@",@"1155"];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"打电话" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"呼叫" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str3]];
        
    }];
    // Add the actions.
    
    [alertController addAction:cancelAction];
    
    [alertController addAction:otherAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

#pragma mark UIAlertAction颜色修改
- (void)changesystemalertview{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认离开支付？" message:@"你的订单在30分钟内未支付将被取消,请尽快支付" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"继续支付" style:UIAlertActionStyleDestructive handler:nil];
    
    UIAlertAction *quiteAction = [UIAlertAction actionWithTitle:@"确定离开" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }];
    
    /*title*/
    NSMutableAttributedString *alertTitleStr = [[NSMutableAttributedString alloc] initWithString:@"提示"];
    [alertTitleStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, alertTitleStr.length)];
    [alertTitleStr addAttribute:NSForegroundColorAttributeName value:[UIColor cyanColor] range:NSMakeRange(0, alertTitleStr.length)];
    [alertController setValue:alertTitleStr forKey:@"attributedTitle"];
    
    /*msg*/
    NSMutableAttributedString *alertMsgStr = [[NSMutableAttributedString alloc] initWithString:@"修改内容"];
    [alertMsgStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, alertMsgStr.length)];
    [alertMsgStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, alertMsgStr.length)];
    [alertController setValue:alertMsgStr forKey:@"attributedMessage"];
    [quiteAction setValue:[UIColor orangeColor] forKey:@"_titleTextColor"];
    [cancleAction setValue:[UIColor redColor] forKey:@"_titleTextColor"];
    
    [alertController addAction:cancleAction];
    [alertController addAction:quiteAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}




#pragma mark 涂鸦测试

- (void)testScrawlView{
    ScrawlViewController *scVC = [[ScrawlViewController alloc] init];
    [self.navigationController pushViewController:scVC animated:YES];
}






- (void)removeAllSubviews{
    //要删除当前View的所有子View下面一行代码即可搞定
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

#pragma 简单的加载转圈

- (void)testLoadingRotate:(BOOL)isRotating{
    
    if (isRotating) {
        [self startRotate:self.imag];
    }else{
        [self stopRotate:self.imag];
    }
}

/**
 开始转圈

 @param loadingImage UIImageView
 */
-(void)startRotate:(UIImageView *)loadingImage{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation.toValue = [NSNumber numberWithFloat:M_PI*2.0];
    rotationAnimation.duration = 1;
    rotationAnimation.repeatCount = HUGE_VALF;
    [loadingImage.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

/**
 停止转圈

 @param loadingImage UIImageView
 */
-(void)stopRotate:(UIImageView *)loadingImage{
    [loadingImage.layer removeAllAnimations];
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(0*(M_PI/180.0f));
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        loadingImage.transform = endAngle;
    } completion:^(BOOL finished) {
    }];
    
    
}

#pragma 选取照片
/**
 选取照片
 */
- (void)pickImage{
    
//    UIImagePickerController *imagePicker=[[UIImagePickerController alloc] init];
//    imagePicker.delegate=self;
//    //    imagePicker.view.frame=s
//    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
//        imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
//
//    }
//    // imagePicker.allowsEditing=YES;
//    //    [self.view addSubview:imagePicker.view];
//    [self presentViewController:imagePicker animated:YES completion:^{
//
//    }];
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        picker.videoQuality = UIImagePickerControllerQualityTypeMedium; //录像质量
        picker.videoMaximumDuration = 600.0f; //录像最长时间
        picker.mediaTypes = [NSArray arrayWithObjects:@"public.movie", nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"当前设备不支持录像功能" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    //跳转到拍摄页面
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"%@",info);
    UIImage *image=[info objectForKey:UIImagePickerControllerOriginalImage];
    
//    self.image.image=image;
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}




/**
 UITextView
 
 @return UITextView
 */
-(UITextView *)textView{
    if (!_textView) {
        //http://www.cnblogs.com/xiaofeixiang/
        _textView=[[UITextView alloc]initWithFrame:CGRectMake(30, 200, CGRectGetWidth([[UIScreen mainScreen] bounds])-60, 10)];
        [_textView setTextColor:[UIColor redColor]];
        [_textView.layer setBorderColor:[[UIColor blackColor] CGColor]];
        [_textView setFont:[UIFont systemFontOfSize:15]];
        [_textView.layer setBorderWidth:1.0f];
        [_textView setDelegate:self];
    }
    return _textView;
}

-(void)textViewDidChange:(UITextView *)textView{
    //博客园-FlyElephant
    static CGFloat maxHeight =60.0f;
    CGRect frame = textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    if (size.height<=frame.size.height) {
        size.height=frame.size.height;
    }else{
        if (size.height >= maxHeight)
        {
            size.height = maxHeight;
            textView.scrollEnabled = YES;   // 允许滚动
        }
        else
        {
            textView.scrollEnabled = NO;    // 不允许滚动
        }
    }
    textView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, size.height);
}



- (void)btnAction:(UIButton *)btn{
    
    
//    dispatch_async(dispatch_get_main_queue(), ^{
////        YourViewController *v = [[YourViewController alloc] init];
//        [self presentViewController:self.vc animated:YES completion:^{}];
//    });

    
    
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 150, 100)];
//    view.backgroundColor = [UIColor yellowColor];
//    
//    [[[LGAlertView alloc] initWithViewAndTitle:@"Autolayouts"
//                                       message:@"You need to set width and height constraints"
//                                         style:LGAlertViewStyleAlert
//                                          view:self.alertVC.view
//                                  buttonTitles:@[@"Done"]
//                             cancelButtonTitle:@"Cancel"
//                        destructiveButtonTitle:nil
//                                      delegate:self] showAnimated:YES completionHandler:nil];
    
    
//    NSLog(@"~~~~~~点击蓝牙~~~~~");
//    EGmyAlertView *alertView = [EGmyAlertView new];
//    [self.view addSubview:alertView];
//    alertView.frame = [UIScreen mainScreen].bounds;
//    imagePickerViewController *contentView = [imagePickerViewController new];
//    alertView.contentView = contentView;
//    [alertView show];
    
//    [self gifPlay2];
    
    
//    [self presentViewController:self.imagePickVC animated:YES completion:nil];
    
   
    
//    UIImage *imag = [UIImage imageWithCGImage:(btn.imageView.image).CGImage];
//    
//    UIImageView *imagView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, 100, 100)];
//    imagView.image = imag;
//    
//    [self.view addSubview:imagView];
    
    
    
//    NSDictionary *dic = @{@"是":@"123"};
//    self.是 = dic[@"是"];
//    
//    NSLog(@"%@~~~~~~~~~",self.是);
}



- (void)dicChangeModle{
    
    NSDictionary *dic = @{
                          @"crId": @102,
                          @"cid": @"1db9366ecd17857b",
                          @"cdid": @62,
                          @"title": @"美国高尔夫球名人赛在太浩湖展开比赛",
                          @"image":@"http://114.215.192.125:8095/golf_operate/attachment/file/20170727/12350482-27b0-4210-9add-66ee05d3443b.jpg,http://114.215.192.125:8095/golf_operate/attachment/file/20170727/fe802004-08ec-48cc-ac52-61e03751ccd3.jpg,http://114.215.192.125:8095/golf_operate/attachment/file/20170727/ce3b80eb-31f9-442b-b1a9-d448382902d5.jpg,http://114.215.192.125:8095/golf_operate/attachment/file/20170727/44e77d96-5c61-4ba6-b2ab-d6df6ce81598.jpg",
                          @"content": @"手肘受伤后差不多2个月未打高尔夫球，回温恢复训练，大帅第一次下场，发挥不错。",
                          @"address": @"中国陕西省西安市雁塔区锦业路",
                          @"account": @"G-4321-2281M70",
                          @"nick": @"新加坡",
                          @"head": @"http://114.215.192.125:8095/golf_operate/attachment/member/20170717/045fa078-e998-40f2-aa4f-5911679d41af.jpg",
                          @"addTime": @"2017-07-27 12:06:07",
                          @"encourageNum":@7,
                          @"encourageList": @[
                                  @{
                                      @"account": @"G-4321-2281M70",
                                      @"nick": @"新加坡",
                                      @"head": @"http://114.215.192.125:8095/golf_operate/attachment/member/20170717/045fa078-e998-40f2-aa4f-5911679d41af.jpg",
                                      @"addTime": @"2017-07-28 14:52:16",
                                      @"fans": @0,
                                      @"identity": @0
                                      },@{
                                      @"account": @"G-4321-2281M70",
                                      @"nick": @"新加坡",
                                      @"head": @"http://114.215.192.125:8095/golf_operate/attachment/member/20170717/045fa078-e998-40f2-aa4f-5911679d41af.jpg",
                                      @"addTime": @"2017-07-28 14:52:16",
                                      @"fans": @0,
                                      @"identity": @0
                                      },@{
                                      @"account": @"G-4321-2281M70",
                                      @"nick": @"新加坡",
                                      @"head": @"http://114.215.192.125:8095/golf_operate/attachment/member/20170717/045fa078-e998-40f2-aa4f-5911679d41af.jpg",
                                      @"addTime": @"2017-07-28 14:52:16",
                                      @"fans": @0,
                                      @"identity": @0
                                      },
                                  ],
                          @"isEncourage": @1
                          };
    
    
    
    NSString *str = [[NSBundle mainBundle] pathForResource:@"werty.plist" ofType:nil];
    
    QWERT *model = [QWERT mj_objectWithKeyValues:dic];
    
    NSLog(@"%@", model);
    
    NSString *account = model.encourageList[0].account;
    
}





-(void)gifPlay2  {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    view.backgroundColor = [UIColor blackColor];
    
    view.alpha = 0.7;
    
    [self.view addSubview:view];
    [view bringSubviewToFront:self.view];
    
    NSString  *gifPath=[[NSBundle mainBundle] pathForResource:@"22" ofType:@"gif"];
    YFGIFImageView  *gifview=[[YFGIFImageView alloc]init];
    gifview.backgroundColor=[UIColor clearColor];
    gifview.gifPath=gifPath;
    gifview.frame=view.frame;
    [view addSubview:gifview];
    [gifview startGIF];
}


#pragma mark - LGAlertViewDelegate

- (void)alertView:(LGAlertView *)alertView clickedButtonAtIndex:(NSUInteger)index title:(nullable NSString *)title {
    NSLog(@"action {title: %@, index: %lu}", title, (long unsigned)index);
}

- (void)alertViewCancelled:(LGAlertView *)alertView {
    NSLog(@"cancel");
}

- (void)alertViewDestructed:(LGAlertView *)alertView {
    NSLog(@"destructive");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
