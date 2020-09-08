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
#import "PlateInputView.h"
#import "threeViewController.h"
#import "ScrawlViewController.h"
#import "LicensePlateView.h"
#import "tabViewSelect.h"

#import "HLWebViewController.h"

#import "JHCusomHistory.h"

#import "ANPopoverView.h"

#import "FDCalendar.h"

#import <objc/message.h>

#pragma mark - 照片浏览器
#import "HZImagesGroupView.h"
#import "HZPhotoItemModel.h"
#import "HZPhotoBrowser.h"
#import "FSLoopScrollView.h"


#import <MediaPlayer/MediaPlayer.h>

#import "SelectLabelShowVC.h"

//#if (DEBUG == 1 || TARGET_OS_SIMULATOR)
//#else
//#ifdef FILELOG_SUPPORT
//[self redirectNSlogToDocumentFolder];
//#endif
//#endif//```

#define FILELOG_SUPPORT(str) [self redirectNSlogToDocumentFolder:str]


#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<LGAlertViewDelegate,UITextViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate,HZPhotoBrowserDelegate>

@property(nonatomic,strong)UIViewController *vc;

@property(nonatomic,strong)alertviewViewController *alertVC;

@property(nonatomic,strong) imagePickerViewController *imagePickVC;

@property(nonatomic,strong)CAShapeLayer *shapeLayer;
@property(nonatomic,strong)CAShapeLayer *shapeLayerTwo;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,assign)CGFloat timeD;
@property(nonatomic,strong)UIView *loadingView;

@property(nonatomic,strong)NSString *是;

@property(nonatomic,strong)UITextView *textView;

@property(nonatomic,strong)NSDictionary *dic;

@property(nonatomic,strong)UIImageView *imag;

@property (nonatomic,strong)PlateInputView * plateInput;
@property (nonatomic,strong)UITextField * plateTextField;

@property (nonatomic,strong)tabViewSelect *tabViewSelect;

@property (nonatomic,assign) NSInteger tmpFlag;

@property (nonatomic, strong) JHCusomHistory *history;

@property (nonatomic ,strong) FDCalendar *calendar;

@property (nonatomic, strong) NSArray *srcStringArray;
@property (nonatomic, strong) FSLoopScrollView *loopView;

@property (nonatomic, strong) MPMoviePlayerController *moviePlayerController;
@end

@implementation ViewController


//三个参数的方法
-(void)take:(NSString *)name andAge:(NSString *)age andBlue:(NSString *)color{
    NSLog(@"%@-%@-%@",name,age,color);
//    return 7;
}
-(void)invocationInstance{
//    1.通过方法调用者创建方法签名；此方法是NSObject 的方法
    NSMethodSignature *sig = [[self class] instanceMethodSignatureForSelector:@selector(take:andAge:andBlue:)];
//    2.通过方法签名 生成NSInvocation
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
//    3.对invocation设置 方法调用者
    invocation.target = self;
//    4.对invocation设置 方法选择器
    invocation.selector = @selector(take:andAge:andBlue:);
//    5.对invocation设置 参数
    NSString *name = @"张三";
    NSString *age = @"20";
    NSString *color = @"red";
    //注意：设置的参数必须从2开始；因为0和1 已经被self ,_cmd 给占用了
    [invocation setArgument:&name atIndex:2];
    [invocation setArgument:&age atIndex:3];
    [invocation setArgument:&color atIndex:4];
//    6.执行invocation
    [invocation invoke];
//    7.判断 方法签名 判断是否有返回值
    const char *sigretun =  sig.methodReturnType; //方法签名的返回值
    NSUInteger siglength = sig.methodReturnLength; //方法签名返回值长度； 如果是字符串返回8，数字返回4，没有返回值返回0；
    if (siglength !=0) { //有返回值
        if (strcmp(sigretun, "@") == 0) {
            NSString *returnStr;
            [invocation getReturnValue:&returnStr];
            NSLog(@"字符串返回值：%@",returnStr);
        }else if (strcmp(sigretun, "i")){
            int a = 0;
            [invocation setReturnValue:&a];
            NSLog(@"数字返回值：%d",a);
        }
    }else{ //没有返回值
        NSLog(@"没有返回值");
    }
    
//    8.常用方法
    NSUInteger argumentNum = sig.numberOfArguments;
    NSLog(@"%zd",argumentNum); //参数的个数
    
    const char *type = [sig getArgumentTypeAtIndex:3];
    NSLog(@"方法签名中下标为3的的参数类型:%s",type);
}
// 扩展
//-(id)performSelector:(SEL)aSelector withObjects:(NSArray *)objects{
//    //生成方法签名
//    NSMethodSignature *sig = [NSMethodSignature methodSignatureForSelector:aSelector];
//    if (sig == nil) { //如果方法签名不存在抛出异常
//        [NSException raise:@"exceptionName" format:@"%@not found method",NSStringFromSelector(aSelector)];
//    }
//    //生成invocation
//    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
//    invocation.target = self;// 设置调用对象
//    invocation.selector = aSelector;//设置方法选择器
//
//    NSInteger num = sig.numberOfArguments -2; //传递进来的参数个数
//    NSInteger min = MAX(num, objects.count); //取得参数的数量；
//    for (int i = 0; i< min; i++) {
//        id obj = objects[i];
//        if ([obj isKindOfClass:[NSNull class]]) continue;
//            //设置参数
//        [invocation setArgument:&obj atIndex:i+2];
//
//    }
//    //调用方法
//    [invocation invoke];
//
//    //获得返回值
//    id retrunvalue = nil;
//    if (sig.methodReturnLength !=0) { //如果有返回值的话，获取返回值
//        [invocation getReturnValue:&retrunvalue];
//    }
//    return retrunvalue;
//
//
//}

- (void)doSomething:(id)index{
    NSLog(@"%@~~~~~~%@~~~",NSStringFromSelector(_cmd),index);
}

- (void)doAnotherThing:(id)index{
    NSLog(@"%@~~~~~~%@~~~",NSStringFromSelector(_cmd),index);
}

- (void)ObjcMsgSendWithString:(NSString *)string withNum:(NSNumber *)number withArray:(NSArray *)array {
    NSLog(@"%@, %@, %@", string, number, array[0]);
}

typedef struct ParameterStruct{
    int a;
    int b;
}MyStruct;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = ANYColorRandom;
    
    NSDictionary *dicemp = @{@"first":@"partridge",@"second": @"turtledoves",@"fifth": @"golden rings"};
    
    NSLog(@"%@",dicemp[@"112222"]);
    
//    [self invocationInstance];
    
    for (NSInteger i = 0; i <2; i ++) {
//        [self performSelector:NSSelectorFromString(@[@"doSomething",@"doAnotherThing"][i])];
        //代替switch
        [self performSelector:NSSelectorFromString(@[@"doSomething:",@"doAnotherThing:"][i]) withObject:@(i)];
    }
    
    NSString *str = @"字符串objc_msgSend";
    NSNumber *num = @20;
    NSArray *arr = @[@"数组值1", @"数组值2"];
    SEL sel = NSSelectorFromString(@"ObjcMsgSendWithString:withNum:withArray:");
    ((void (*) (id, SEL, NSString *, NSNumber *, NSArray *))objc_msgSend)(self, sel, str, num, arr);
    
    
    MyStruct mystruct = {10,20};
    NSValue *value = [NSValue valueWithBytes:&mystruct objCType:@encode(MyStruct)];
    
    MyStruct struceBack;
    [value getValue:&struceBack];
    NSLog(@"%d~~~~~~~~~",struceBack.a);
    
    NSProxy *prox = [NSProxy alloc];
    
//    UIView *loadingView = [[UIView alloc]initWithFrame:CGRectMake(200, 300, 100, 100)];
//    [self.view addSubview:loadingView];
//    self.loadingView = loadingView;
//    loadingView.backgroundColor = [UIColor blueColor];
    
//    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushtoDetailVC:)];
//    tapGesture.numberOfTouchesRequired=1;
//    tapGesture.numberOfTapsRequired=1;
//    tapGesture.delegate = self;
//    [loadingView addGestureRecognizer:tapGesture];
//
//    UILabel *labtmp = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    labtmp.textColor = [UIColor redColor];
//    labtmp.font = [UIFont systemFontOfSize:15];
//    labtmp.text = @"我是第一";
//    [self.loadingView addSubview:labtmp];
//
//    self.title = @"我是第一";
    
    
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
    
    
    
//    //添加历史记录视图
//    self.history.searchKey = @"45678";
//    self.history.searchKey = @"sx";
//    self.history.searchKey = @"2345ydfc";
//    self.history.searchKey = @"oiudc1234";
//    self.history.searchKey = @"456yhbcx";
//
//    [self.view addSubview:self.history];
    
}

-(void)click:(UIButton *)btn{
    btn.selected = !btn.selected;
//    SelectLabelShowVC *scVC = [[SelectLabelShowVC alloc] init];
//    [self.navigationController pushViewController:scVC animated:YES];
    [self ImagesGroupView];
}



/// keep首页动画
- (void)keepLaunchAnimation{
    NSString *moviePath = [[NSBundle mainBundle] pathForResource:@"keep" ofType:@"mp4"];
    
    self.moviePlayerController.contentURL = [[NSURL alloc] initFileURLWithPath:moviePath];
    
    [self.moviePlayerController play];
    
    [self.moviePlayerController.view bringSubviewToFront:self.view];
}
#pragma mark - NSNotificationCenter
- (void)playbackStateChanged
{
    MPMoviePlaybackState playbackState = [self.moviePlayerController playbackState];
    if (playbackState == MPMoviePlaybackStateStopped || playbackState == MPMoviePlaybackStatePaused) {
        [self.moviePlayerController play];
    }
}
#pragma mark - setter and getter
- (MPMoviePlayerController *)moviePlayerController
{
    if (!_moviePlayerController) {
        
        _moviePlayerController = [[MPMoviePlayerController alloc] init];
        
        [_moviePlayerController setShouldAutoplay:YES];
        
        _moviePlayerController.movieSourceType = MPMovieSourceTypeFile;
        [_moviePlayerController setFullscreen:YES];
        
        [_moviePlayerController setRepeatMode:MPMovieRepeatModeOne];
        _moviePlayerController.controlStyle = MPMovieControlStyleNone;
        _moviePlayerController.view.frame = [UIScreen mainScreen].bounds;
        
        [self.view addSubview:self.moviePlayerController.view];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackStateChanged) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
        
    }
    return _moviePlayerController;
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

#pragma 历史记录相关
- (JHCusomHistory *)history{
    if (!_history) {
        __weak typeof(self) weakSelf = self;
        JHCusomHistory *history = [[JHCusomHistory alloc] initWithFrame:CGRectMake(0, 200, 400, 200) maxSaveNum:5 fileName:@"parkingHistorySearch.data" andItemClickBlock:^(NSString *keyword) {
            NSLog(@"~~~~%@",keyword);
            
        }];
        history.backgroundColor = [UIColor purpleColor];
        _history = history;
    }
    return _history;
}

#pragma mark - 照片浏览器
- (NSArray *)srcStringArray{
    if (!_srcStringArray) {
        _srcStringArray = @[
                            @"http://ww2.sinaimg.cn/thumbnail/98719e4agw1e5j49zmf21j20c80c8mxi.jpg",
                            @"http://ww2.sinaimg.cn/thumbnail/642beb18gw1ep3629gfm0g206o050b2a.gif",
                            @"http://ww2.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr2n1jjj20gy0o9tcc.jpg",
                            @"http://ww2.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr39ht9j20gy0o6q74.jpg",
                            @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr3xvtlj20gy0obadv.jpg",
                            @"http://ww4.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr4nndfj20gy0o9q6i.jpg",
                            @"http://ww3.sinaimg.cn/thumbnail/8e88b0c1gw1e9lpr57tn9j20gy0obn0f.jpg",
                            @"http://ww2.sinaimg.cn/thumbnail/677febf5gw1erma104rhyj20k03dz16y.jpg",
                            @"http://ww4.sinaimg.cn/thumbnail/677febf5gw1erma1g5xd0j20k0esa7wj.jpg",
                            ];
    }
    return _srcStringArray;
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


- (void)popoverView:(UIButton *)btn{
    ANPopoverView *popoverView = [ANPopoverView popoverView];
    [popoverView showToView:btn withActions:@"只有初恋般的热情和宗教般的意志，人才有可能成就某种事业。 尽管创造的过程无比艰辛而成功的结果无比荣耀；尽管一切艰辛都是为了成功，但是，人生最大的幸福也许在于创造的过程，而不在于那个结果。 读书如果不是一种消遣，那是相当熬人的，就像长时间不间断地游泳，使人精疲力竭，有一种随时溺没的感觉。"];
}

- (void)addCalendar{
    FDCalendar *calendar = [[FDCalendar alloc] initWithCurrentDate:[NSDate date] weekBackColor:[UIColor orangeColor] dateArray:nil addCalendarStyle:CalendarStyle1];
    self.calendar = calendar;
    //    CGRect frame = calendar.frame;
    //    frame.origin.y = 0;
    calendar.frame = CGRectMake(0, 70, kScreenWidth, kScreenHeight - 70 - 10);
    [self.view addSubview:calendar];
}

#pragma mark - 照片浏览器
- (void)ImagesGroupView{
    
    
    HZImagesGroupView *imagesGroupView = [[HZImagesGroupView alloc] initWithFrame:CGRectMake(0, 180, kScreenWidth, kScreenHeight - 80 - 30)];
    NSMutableArray *temp = [NSMutableArray array];
    [self.srcStringArray enumerateObjectsUsingBlock:^(NSString *src, NSUInteger idx, BOOL *stop) {
        HZPhotoItemModel *item = [[HZPhotoItemModel alloc] init];
        item.thumbnail_pic = src;
        [temp addObject:item];
    }];
    imagesGroupView.photoItemArray = [temp copy];
    imagesGroupView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:imagesGroupView];
//    imagesGroupView.hidden = YES;
//    [imagesGroupView showGigPhotoBrowser];
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


//隐藏键盘

-(void)pushtoDetailVC:(UITapGestureRecognizer *)Recognizer{
    NSLog(@"2345678ujm");
}


#pragma mark 通过宏调用自定义方法 --- 无参数无返回值的宏，带参数的宏，带返回值的宏，
- (void)defineFunction{
    FILELOG_SUPPORT(@"2222");
    NSString *str = FILELOG_SUPPORT(@"2222");
    NSLog(@"%@",str);
}

- (NSString *)redirectNSlogToDocumentFolder:(NSString *)str{
    NSLog(@"通过宏定义调用自定义的方法~~~~%@",str);
    NSString *strReturn = @"我是返回值";
    return strReturn;
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


#pragma mark TableView单选
- (void)selectTabViewCell{
    self.tabViewSelect = [[tabViewSelect alloc] init];
    self.tabViewSelect.selecTitle = @"tabViewSelect单选";
//    __weak typeof(self) weakSelf = self;
    NSArray *allArr = @[@"不限",@"以后再告诉你",@"与父母同住",@"租房",@"已购房（有贷款）",@"已购房（无贷款）",@"住单位房",@"住亲朋家",@"需要时购置"];
    self.tabViewSelect.dataArr = allArr;
    self.tabViewSelect.config = ^(NSString *contentTitle){
        NSLog(@"%@",contentTitle);
    };
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.tabViewSelect];
}

#pragma mark 涂鸦测试

- (void)testScrawlView{
    ScrawlViewController *scVC = [[ScrawlViewController alloc] init];
    [self.navigationController pushViewController:scVC animated:YES];
}


#pragma mark 车牌号输入
- (void)plateNumber{
    _plateTextField = [[UITextField alloc]initWithFrame:CGRectMake(30, 100, WIDTH-60, 50)];
    _plateTextField.delegate = self;
    _plateTextField.layer.borderColor = [UIColor blackColor].CGColor;
    _plateTextField.layer.borderWidth = 1;
    _plateTextField.keyboardType = UIKeyboardTypeNumberPad;//设置数字键盘防止复制粘贴板自动加空格
    
//    UIView *inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 200 )];
    
//    UIView *tmpView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
//    tmpView.backgroundColor = [UIColor cyanColor];
//    [inputView addSubview:tmpView];
    
//    UIButton *but = [[UIButton alloc] initWithFrame:CGRectMake(20, 30, 80, 20)];
//    but.backgroundColor = [UIColor orangeColor];
//    [but addTarget:self action:@selector(btnadd) forControlEvents:(UIControlEventTouchUpInside)];
//    [tmpView addSubview:but];
//
//    _plateTextField.inputView = inputView;
//    [self.view addSubview:_plateTextField];
    
    
    LicensePlateView *carView = [LicensePlateView initFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, (([UIScreen mainScreen].bounds.size.height) / 568) *180) OriginalString:_plateTextField.text block:^(NSString *str) {
        NSLog(@"str = %@",str);
        self.plateTextField.text = str;
        if (str.length == 8) {
            [self.plateTextField resignFirstResponder];
        }
    }];
    carView.backgroundColor = [UIColor whiteColor];
    UIView *inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, (([UIScreen mainScreen].bounds.size.height) / 568) *180)];
    inputView.backgroundColor = [UIColor greenColor];
    [inputView addSubview:carView];
    self.plateTextField.inputView = inputView;
    [self.view addSubview:_plateTextField];
    
}


- (void)btnadd{
    NSLog(@"23456yhhjkl");
}

#pragma mark 车牌号输入框监听及代理方法

-(void)textChange:(UITextField *)textField{
    NSString * str = textField.text;
    _plateInput.plateStr = str;
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString * str = textField.text;
    
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    str = [str stringByReplacingCharactersInRange:range withString:string];
    
    if (str.length>0) {
        NSArray * provinceArr = @[@"京",@"津",@"晋",@"冀",@"蒙",@"辽",@"黑",@"吉",@"沪",@"苏",@"浙",@"皖",@"闽",@"赣",@"鲁",@"豫",@"鄂",@"湘",@"粤",@"桂",@"琼",@"渝",@"川",@"贵",@"云",@"藏",@"陕",@"甘",@"青",@"宁",@"新",@"W"];
        
        if (str.length>8) {
            return NO;
        }else if (![provinceArr containsObject:[str substringToIndex:1]]) {
            return NO;
        }else{
            for (NSString * enumStr in provinceArr) {
                
                if ([enumStr isEqualToString:@"W"]) {
                    
                }else if ([[str substringWithRange:NSMakeRange(1, str.length-1)] rangeOfString:enumStr].location != NSNotFound ) {
                    return NO;
                }
            }
        }
    }
    _plateInput.plateStr = str;
    
    return YES;
}

-(void)tapClick:(UITapGestureRecognizer *)tap{
    [tap.view endEditing:YES];
}



- (void)removeAllSubviews{
    
    //要删除当前View的所有子View下面一行代码即可搞定
    [self.loadingView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.loadingView.frame = CGRectMake(200, 300, 100, 0);
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


/**
 *   使用stringByTrimmingCharactersInSet函数过滤字符串中的特殊符号。
 */
-(void)testThree{
    
    //1:有字符串“A~B^C_D>E"，拆分出单个字母:
    
    NSString *str =@"      \nA~B^C_D>E       ";
    
    //去掉前边和后边的空格和换行符,中间部分无效.
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSCharacterSet * charSet = [NSCharacterSet characterSetWithCharactersInString:@"^~_>"];
    NSArray *arr = [str componentsSeparatedByCharactersInSet:charSet];
    
    //输出看效果
    [arr enumerateObjectsUsingBlock:^(id obj,NSUInteger idx,BOOL *stop) {
        
        NSLog(@"A~B^C_D->[%@]", obj);
        
    }];
    NSLog(@"arr %@",[arr componentsJoinedByString:@""]);//arr ABCDE
    
}

- (void)btnAction:(UIButton *)btn{
    [self testThree];
    
    NSString *string1 = @"ABCDEFGHIJKL\nMNOPQRSTUVsWXYZ";
    NSLog(@"%@~~~~~~~~~",string1);
    
    alertviewViewController *vc = [alertviewViewController new];
    [self.navigationController pushViewController:vc animated:YES];
    
    
    //取出两个数组中相同的元素
    NSArray *arr1 = @[@"1",@"2",@"2",@"1",@"3",@"4",@"5",@"2",@"1",@"2",@"5",@"3",@"2",@"3",@"4",@"5",@"6",@"7",@"8"];
    NSArray *arr2 = @[@"13",@"2",@"2",@"1",@"31",@"42",@"52",@"22",@"12",@"2",@"54",@"3",@"2",@"13",@"4",@"5",@"6",@"7",@"8"];
    
    NSArray *selectTure = [arr1 filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF in %@", arr2]];
    
    NSLog(@"%@~~~~~~~~~",selectTure);
    
//    这样arrayContent过滤出来的就是不包含 arrayFilter中的所有item了。
    NSArray *arrayFilter = [NSArray arrayWithObjects:@"abc1", @"abc2", nil];
    
    NSArray *arrayContent = [NSArray arrayWithObjects:@"a1", @"abc1", @"abc4", @"abc2", nil];
    
    NSPredicate *thePredicate = [NSPredicate predicateWithFormat:@"NOT (SELF in %@)", arrayFilter];
    
    NSArray *selectTure22 = [arrayContent filteredArrayUsingPredicate:thePredicate];
    
//    NSString *a = @"12wertyu";
//   NSString *b =  [a substringWithRange:NSMakeRange(0, 1)];
//    NSLog(@"%@",b);
//    
//   NSString *c = [a substringWithRange:NSMakeRange(3, 2)];
//    
//    NSLog(@"%@",c);
   
    
    NSString *string =@"01234￥56789";
    NSRange range = [string rangeOfString:@"￥"];
    string = [string substringFromIndex:range.location+1];//截取掉下标7之前的字符串
//    NSLog(@"截取的值为：%@",string);
    
//    NSRange range = [string rangeOfString:@":"]; //现获取要截取的字符串位置
//    NSString * result = [string substringFromIndex:range.location+1]; //截取字符串
//    NSLog(@"截取的值为：%@",result);
//
////    string = [string substringFromIndex:1];//截取掉下标2之后的字符串
//    NSLog(@"截取的值为：%@",result);
    
//    NSRange range = [str rangeOfString:@"aaa"]; //现获取要截取的字符串位置
//    NSString * result = [str substringFromIndex:range.location]; //截取字符串
    
    
    
    
    
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
    
    [self recell];
//
//    float Intervaltime = 0.5;
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:Intervaltime target:self selector:@selector(circleAnimation) userInfo:nil repeats:YES];
    
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


- (void)recell{
    //创建出CAShapelasyer
    self.shapeLayer = [CAShapeLayer layer];
    //填充颜色
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
    //设置线条的宽度和颜色
    self.shapeLayer.lineWidth = 4.0f;
    self.shapeLayer.strokeColor = [UIColor orangeColor].CGColor;
    

    self.shapeLayerTwo = [CAShapeLayer layer];
    self.shapeLayerTwo.fillColor = [UIColor clearColor].CGColor;
    //设置第二条背景线条的宽度和颜色
    self.shapeLayerTwo.lineWidth = 4.0f;
    self.shapeLayerTwo.strokeColor = [UIColor redColor].CGColor;
    
    //画贝塞尔曲线//画出一个园
    UIBezierPath *path = [[UIBezierPath alloc] init];
    //moveToPoint:去设置初始线段的起点
    [path moveToPoint:CGPointMake(100, 50)];
    [path addArcWithCenter:CGPointMake(50, 50) radius:50 startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    //设置第一条第一条曲线与设定的贝塞尔曲线相同，所以在设定两条曲线的时候，可以不需要设置大小与位置
    self.shapeLayer.path = path.CGPath;
    self.shapeLayerTwo.path = path.CGPath;
    
    //设置起始点.保证圈不被显示出来
    self.shapeLayer.strokeStart = 0;
    self.shapeLayer.strokeEnd = 0;
    //加载
    [self.loadingView.layer addSublayer:self.shapeLayerTwo];
    [self.loadingView.layer addSublayer:self.shapeLayer];
}


//定时器每次时间到了执行
- (void)circleAnimation{
   _timeD = 0.5;
    //利用定时器控制始位置的方式做动画。
    self.shapeLayer.strokeEnd +=_timeD;
    if (self.shapeLayer.strokeEnd == 1) {
        //停止计时器
        [self.timer invalidate];
        self.timer = nil;
    }
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
