//
//  ViewController.m
//  手势解锁
//
//  Created by liujianjian on 16/1/6.
//  Copyright © 2016年 rdg. All rights reserved.
//

#import "ViewController.h"
#import "JJGestureRecognitionView.h"

@interface ViewController ()<JJGestureRecognitionViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    JJGestureRecognitionView *gesView = [[JJGestureRecognitionView alloc] init];
//    gesView.delegate = self;
    gesView.bounds = CGRectMake(0, 0, 300, 300);
    gesView.backgroundColor = [UIColor clearColor];
    gesView.center = self.view.center;
    [self.view addSubview:gesView];
    
    gesView.gestureRecognitionViewSlidingpathBlock = ^(JJGestureRecognitionView *view, NSString *slidingpath){
        NSLog(@"slidingpath = %@", slidingpath);
    };
    
}
- (void)gestureRecognitionView:(JJGestureRecognitionView *)gestureRecognitionView slidingpath:(NSString *)slidingpath {
    NSLog(@"slidingpath = %@", slidingpath);
}



@end
