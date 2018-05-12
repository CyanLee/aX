//
//  WelcomeViewController.m
//  商速老板助手
//
//  Created by 今日 on 2018/5/12.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIButton *clickBtn;

/** 定时器(这里不用带*，因为dispatch_source_t就是个类，内部已经包含了*) */
@property (nonatomic, strong) dispatch_source_t timer;

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://www.shopspeed.cn:80/shopspeed_points/images/logo/default_logo.jpg"]];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://www.shopspeed.cn:80/shopspeed_points/images/logo/default_logo.jpg"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [self clickBtn];
        [self createTimer];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self.view addSubview:_imageView];
    }
    return _imageView;
}

-(UIButton *)clickBtn{
    if (_clickBtn == nil) {
        _clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _clickBtn.backgroundColor = [UIColor colorWithRed:83/255.0 green:96/255.0 blue:96/255.0 alpha:0.3];
        [_clickBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_clickBtn setTitle:@"4" forState:UIControlStateNormal];
        [_clickBtn addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
        [self.imageView addSubview:_clickBtn];
        [_clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(50);
            make.right.mas_equalTo(-25);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(30);
        }];
    }
    return _clickBtn;
}

-(void)createTimer{
    __weak __typeof(&*self)weakSelf =self;
    __block int count = 4;
    // 获得队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    // 创建一个定时器(dispatch_source_t本质还是个OC对象)
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 设置定时器的各种属性（几时开始任务，每隔多长时间执行一次）
    // GCD的时间参数，一般是纳秒（1秒 == 10的9次方纳秒）
    // 何时开始执行第一个任务
    // dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC) 比当前时间晚3秒
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
    uint64_t interval = (uint64_t)(1.0 * NSEC_PER_SEC);
    dispatch_source_set_timer(self.timer, start, interval, 0);
    // 设置回调
    dispatch_source_set_event_handler(weakSelf.timer, ^{
        NSLog(@"------------%@", [NSThread currentThread]);
        count--;
        [weakSelf updataUI:count];
        if (count == 0) {
            // 取消定时器
            dispatch_cancel(self.timer);
            weakSelf.timer = nil;
            [weakSelf action];
        }
    });
    
    // 启动定时器
    dispatch_resume(self.timer);
}

-(void)updataUI:(int)count{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.clickBtn setTitle:[NSString stringWithFormat:@"%d",count] forState:UIControlStateNormal];
    });
}

-(void)action{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.welcomeWindow.hidden = YES;
    //释放欢迎控制器的指针索引
    delegate.welcomeWindow.rootViewController = nil;
    delegate.welcomeWindow = nil;
}

-(void)dealloc{
    NSLog(@"我被释放了");
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
