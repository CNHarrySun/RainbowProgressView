//
//  RainbowProgressView.m
//  RainbowProgressView
//
//  Created by HarrySun on 2016/10/8.
//  Copyright © 2016年 Mobby. All rights reserved.
//

#import "RainbowProgressView.h"


@interface RainbowProgressView ()

/**
 *  背景图，彩色进度条，五个星星的ImageView
 */
@property (nonatomic, strong) UIImageView *backgroundImageView,*foregroundImageView,*xingImageView1,*xingImageView2,*xingImageView3,*xingImageView4,*xingImageView5;

/**
 *  定时器
 */
@property (nonatomic, strong) NSTimer *myTimer;

/**
 *  时间Label
 */
@property (nonatomic, strong) UILabel *timeLable;

/**
 *  记录frame
 */
@property (nonatomic, assign) CGRect myFrame;

@end




@implementation RainbowProgressView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.myFrame = frame;
        self.backgroundColor = [UIColor clearColor];
        _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.myFrame.size.width - 2, frame.size.height / 2)];
        _backgroundImageView.image = [UIImage imageNamed:@"8xljindutiao1"];
        [self addSubview:_backgroundImageView];
        
        _foregroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.myFrame.size.width - 2, frame.size.height / 2)];
        _foregroundImageView.image = [UIImage imageNamed:@"8caijindutiao"];
        //如果子视图超出父视图大小时被裁剪掉
        _foregroundImageView.contentMode = UIViewContentModeRight;
        _foregroundImageView.clipsToBounds=YES;
        [self addSubview:_foregroundImageView];

        
        self.timeLable = [[UILabel alloc] initWithFrame:CGRectMake(224, 35, 73, 34)];
        _timeLable.textColor = [UIColor whiteColor];
        _timeLable.font = [UIFont fontWithName:@"FZCuYuan-M03S" size:23];
        _timeLable.text = [NSString stringWithFormat:@"%@",[self timetransform:_currentCountDown]];
        _timeLable.textAlignment =NSTextAlignmentCenter;
        [self  addSubview:_timeLable];
        
        CGFloat scale1 = 60/120.0;
        CGFloat scale2 = 75/120.0;
        CGFloat scale3 = 90/120.0;
        CGFloat scale4 = 105/120.0;
        CGFloat scale5 = 120/120.0;
        self.starNumber = 5;
        
        self.xingImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake((self.myFrame.size.width - 2) * scale1 - 26, -14, 51, 50)];
        [self addSubview:_xingImageView1];
        
        self.xingImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake((self.myFrame.size.width - 2) * scale2 - 26, -14, 51, 50)];
        [self addSubview:_xingImageView2];
        
        self.xingImageView3 = [[UIImageView alloc] initWithFrame:CGRectMake((self.myFrame.size.width - 2) * scale3 - 26, -11, 51, 50)];
        [self addSubview:_xingImageView3];
        
        self.xingImageView4 = [[UIImageView alloc] initWithFrame:CGRectMake((self.myFrame.size.width - 2) * scale4 - 26, -6, 51, 50)];
        [self addSubview:_xingImageView4];
        
        self.xingImageView5 = [[UIImageView alloc] initWithFrame:CGRectMake((self.myFrame.size.width - 2) * scale5 - 26, 0, 51, 50)];
        [self addSubview:_xingImageView5];
        
    }
    return self;
}

#pragma mark - 倒计时
- (void)startCount{
    
    if (_myTimer != nil) {
        [self removeTimer];
    }
    
    _myTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    [_myTimer fire];
}

/**
 *  获取总时间
 *
 *  @param allTime 总时间
 */
- (void)setAllTime:(NSInteger)allTime{
    
    _allTime = allTime;
    
    [self resetStarImgStatus];
    
    _progress = 0;
    
    self.currentCountDown = _allTime;
}


/**
 *  修改彩色进度条显示的大小
 *
 *  @param progress 比例
 */
- (void)setProgress:(double)progress{
    
    _progress = progress;
    
    _foregroundImageView.frame = CGRectMake((self.myFrame.size.width - 2) * _progress, 0, (self.myFrame.size.width - 2) - (self.myFrame.size.width - 2) * _progress, 38);
    
}

/**
 *  修改星星需要灭几个
 *
 *  @param currentCountDown 灭星星的个数
 */
- (void)setCurrentCountDown:(NSInteger)currentCountDown{
    
    _currentCountDown = currentCountDown;
    self.useTime = self.allTime - self.currentCountDown;
    
    NSString *strTime = [self timetransform:self.currentCountDown];
    _timeLable.text = [NSString stringWithFormat:@"%@",strTime];
    
    if (_allTime - _currentCountDown > 119 * self.allTime / 120.0){
        _xingImageView5.image = [UIImage imageNamed:@"8tixingxing"];
        self.starNumber = 0;
        
    }else if (_allTime - _currentCountDown > 105* self.allTime / 120.0){
        self.starNumber = 1;
        _xingImageView4.image = [UIImage imageNamed:@"8tixingxing"];
    }else if(_allTime - _currentCountDown > 90* self.allTime / 120.0){
        self.starNumber = 2;
        _xingImageView3.image = [UIImage imageNamed:@"8tixingxing"];
    }else if (_allTime - _currentCountDown > 75* self.allTime / 120.0){
        self.starNumber = 3;
        _xingImageView2.image = [UIImage imageNamed:@"8tixingxing"];
    }else if(_allTime - _currentCountDown > 60* self.allTime / 120.0) {
        self.starNumber = 4;
        _xingImageView1.image = [UIImage imageNamed:@"8tixingxing"];
    }else{
        self.starNumber = 5;
    }
}


- (void)resetStarImgStatus {
    
    _foregroundImageView.frame = CGRectMake(0, 0, (self.myFrame.size.width - 2), 38);
    _xingImageView5.image = [UIImage imageNamed:@"8tixingxingliang"];
    _xingImageView4.image = [UIImage imageNamed:@"8tixingxingliang"];
    _xingImageView3.image = [UIImage imageNamed:@"8tixingxingliang"];
    _xingImageView2.image = [UIImage imageNamed:@"8tixingxingliang"];
    _xingImageView1.image = [UIImage imageNamed:@"8tixingxingliang"];
    
}

/**
 *  修改进度
 */
- (void)changeProgress{
    
    if (self.progress >= 1) {
        self.progress = 0;
    }else{
        self.progress += (0.1 / (self.allTime * 1.0));
    }
}

/**
 *  剩余的时间
 */
- (void)countDown{
    
    static NSInteger count = 0;
    
    if (_currentCountDown >0) {
        
        [self changeProgress];
        count ++;
        if (count == 10) {
            count = 0;
            self.currentCountDown -= 1;
        }
    }else{
        
        _timeLable.text = @"00 : 00";
        if (_delegate && [_delegate respondsToSelector:@selector(presentAlertView)]) {
            [_delegate presentAlertView];
        }
        [self removeTimer];
    }
    
}

/**
 *  时间转换
 *
 *  @param time 需要转换的时间
 *
 *  @return 返回02:00格式的字符串
 */
- (NSString *)timetransform:(NSInteger)time{
    
    int inputSeconds = (int)time;
    int hours =  inputSeconds / 3600;
    int minutes = ( inputSeconds - hours * 3600 ) / 60;
    int seconds = inputSeconds - hours * 3600 - minutes * 60;
    return [NSString stringWithFormat:@"%.2d : %.2d",minutes, seconds];
}

/**
 *  移除定时器
 */
- (void)removeTimer{
    
    [_myTimer invalidate];
    _myTimer = nil;
    
}


@end
