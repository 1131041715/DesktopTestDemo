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

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<LGAlertViewDelegate,UITextViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate>

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

@property (nonatomic ,strong)tabViewSelect *tabViewSelect;
@end

@implementation ViewController



- (imagePickerViewController *)imagePickVC{
    if (!_imagePickVC) {
        _imagePickVC = [imagePickerViewController new];
//        _imagePickVC.view.frame = CGRectMake(0, 0, 200,200 );
    }
    return _imagePickVC;
}


- (alertviewViewController *)alertVC{
    if (!_alertVC) {
        _alertVC = [alertviewViewController new];
        
        _alertVC.view.frame = CGRectMake(0, 0, 200, 200);
//        _alertVC.view.backgroundColor = [UIColor redColor];
//        [self addChildViewController:_alertVC];
    }
    return _alertVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *loadingView = [[UIView alloc]initWithFrame:CGRectMake(200, 300, 100, 100)];
    [self.view addSubview:loadingView];
    self.loadingView = loadingView;
    loadingView.backgroundColor = [UIColor blueColor];
    
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushtoDetailVC:)];
    tapGesture.numberOfTouchesRequired=1;
    tapGesture.numberOfTapsRequired=1;
    tapGesture.delegate = self;
    [loadingView addGestureRecognizer:tapGesture];
    
    UILabel *labtmp = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    labtmp.textColor = [UIColor redColor];
    labtmp.font = [UIFont systemFontOfSize:15];
    labtmp.text = @"我是第一";
    [self.loadingView addSubview:labtmp];
    
    self.title = @"我是第一";
    
    
    _dic = [NSDictionary new];
    
    EFButton *btn = [EFButton new];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(100, 100, 40, 40);
    [btn setTitle:@"客服服务" forState:(UIControlStateNormal)];
    [btn setImage:[UIImage imageNamed:@"qwas.png"] forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
    
//    [self recell];
    
    
//    [self.view addSubview:self.textView];
    
    
    UIImageView *imag = [[UIImageView alloc] initWithFrame:CGRectMake(200, 100, 100, 100)];
    imag.image = [UIImage imageNamed:@"rp"];
    [self.view addSubview:imag];
    self.imag = imag;
//
//    self.view.backgroundColor = [UIColor blueColor];
    
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"M_sousuokuang"]];
    
}


//隐藏键盘

-(void)pushtoDetailVC:(UITapGestureRecognizer *)Recognizer{
    NSLog(@"2345678ujm");
}


-(void)click:(UIButton *)btn{
    btn.selected = !btn.selected;
//    threeViewController *vc = [[threeViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    HLWebViewController *HLWebvc = [[HLWebViewController alloc] init];
    NSString *cententStr = @"<p><img src=\"http://47.98.50.57/image-server/advert_photo/DC/61/5617E6A35651BB6C1123BB42632EDC61.jpg\"><br></p>";
    HLWebvc.html = cententStr;
//    HLWebvc.url = @"http://47.98.50.57/image-server/advert_photo/DC/61/5617E6A35651BB6C1123BB42632EDC61.jpg";
    [self.navigationController pushViewController:HLWebvc animated:YES];
    
    
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
    
    UIView *inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 200 )];
    
    UIView *tmpView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
    tmpView.backgroundColor = [UIColor cyanColor];
    [inputView addSubview:tmpView];
    
    UIButton *but = [[UIButton alloc] initWithFrame:CGRectMake(20, 30, 80, 20)];
    but.backgroundColor = [UIColor orangeColor];
    [but addTarget:self action:@selector(btnadd) forControlEvents:(UIControlEventTouchUpInside)];
    [tmpView addSubview:but];
    
    _plateTextField.inputView = inputView;
    [self.view addSubview:_plateTextField];
    
    
//    LicensePlateView *carView = [LicensePlateView initFrame:CGRectMake(0, 0, SCREEN_WIDTH, (([UIScreen mainScreen].bounds.size.height) / 568) *180) OriginalString:textField.text block:^(NSString *str) {
//        NSLog(@"str = %@",str);
//        textField.text = str;
//        if (str.length == 8) {
//            [textField resignFirstResponder];
//        }
//    }];
//    carView.backgroundColor = [UIColor whiteColor];
//    UIView *inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (([UIScreen mainScreen].bounds.size.height) / 568) *180)];
//    inputView.backgroundColor = [UIColor greenColor];
//    [inputView addSubview:carView];
//    textField.inputView = inputView;
    
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
