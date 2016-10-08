//
//  RainbowProgressView.h
//  RainbowProgressView
//
//  Created by HarrySun on 2016/10/8.
//  Copyright © 2016年 Mobby. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol RainbowProgressViewDelegate <NSObject>

- (void)presentAlertView;

@end

@interface RainbowProgressView : UIView

/**
 *  未灭星星个数
 */
@property (nonatomic, assign) NSInteger starNumber;
@property (nonatomic, assign) double progress;
/**
 *  剩余的时间，总时间，用时
 */
@property (nonatomic, assign) NSInteger currentCountDown,allTime,useTime;
@property (nonatomic, assign) id <RainbowProgressViewDelegate> delegate;

/**
 *  开始定时器
 */
- (void)startCount;

/**
 *  移除定时器
 */
- (void)removeTimer;

@end
