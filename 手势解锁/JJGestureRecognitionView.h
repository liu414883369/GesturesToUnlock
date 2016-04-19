//
//  JJGestureRecognitionView.h
//  手势解锁
//
//  Created by liujianjian on 16/1/6.
//  Copyright © 2016年 rdg. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JJGestureRecognitionView;

typedef void(^JJGestureRecognitionViewSlidingpathBlock)(JJGestureRecognitionView *, NSString *);

@protocol JJGestureRecognitionViewDelegate <NSObject>

@optional
/**
 *  代理回调
 *
 *  @param gestureRecognitionView self
 *  @param slidingpath            滑过的轨迹
 */
- (void)gestureRecognitionView:(JJGestureRecognitionView *)gestureRecognitionView slidingpath:(NSString *)slidingpath;

@end

@interface JJGestureRecognitionView : UIView
/**
 *  代理
 */
@property (nonatomic, assign)id<JJGestureRecognitionViewDelegate> delegate;
/**
 *  block回调
 */
@property (nonatomic, copy)JJGestureRecognitionViewSlidingpathBlock gestureRecognitionViewSlidingpathBlock;


@end
