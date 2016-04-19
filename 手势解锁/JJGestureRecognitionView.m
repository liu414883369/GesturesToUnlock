//
//  JJGestureRecognitionView.m
//  手势解锁
//
//  Created by liujianjian on 16/1/6.
//  Copyright © 2016年 rdg. All rights reserved.
//

#import "JJGestureRecognitionView.h"

#define kBtnW 64.0
#define kBtnH 64.0

@interface JJGestureRecognitionView ()
/**
 *  存储手指滑过的按钮
 */
@property (nonatomic, strong)NSMutableArray *selectedBtns;
/**
 *  手指当前所在的点（非按钮区域）
 */
@property (nonatomic, assign)CGPoint currentPoint;

@end

@implementation JJGestureRecognitionView

- (NSMutableArray *)selectedBtns {
    if (!_selectedBtns) {
        self.selectedBtns = [NSMutableArray array];
    }
    return _selectedBtns;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self makeSubviews];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self makeSubviews];
    }
    return self;
}
- (void)makeSubviews {
    for (int i = 0; i < 9; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.userInteractionEnabled = NO;
        btn.backgroundColor = [UIColor clearColor];
        btn.tag = i;
        [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
//        [btn setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateHighlighted];
        [self addSubview:btn];
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    for (int i = 0; i < self.subviews.count; i++) {
        UIView *view = self.subviews[i];
        CGFloat viewW = kBtnW; // 宽
        CGFloat viewH = kBtnH; // 高
        
        int column = 3; // 列数
        int varX = i % column; // x方向上的坐标（不会大于列数0\1\2）
        int varY = i / column; // y方向上的坐标
        
        CGFloat margin = (self.frame.size.width - viewW * column) / (column + 1); // 子控件X方向上间距
        
        CGFloat viewX = margin + (viewW + margin) * varX;
        CGFloat viewY = margin + (viewH + margin) * varY;
        
        view.frame = CGRectMake(viewX, viewY, viewW, viewH);
        
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    for (UIButton *view in self.subviews) {
        if (CGRectContainsPoint(view.frame, point)) {
            [self.selectedBtns addObject:view];
            view.selected = YES;
        } else {
            self.currentPoint = point;
        }
    }
    [self setNeedsDisplay];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    for (UIButton *view in self.subviews) {
        if (CGRectContainsPoint(view.frame, point) && ![self.selectedBtns containsObject:view]) {
            [self.selectedBtns addObject:view];
            view.selected = YES;
        } else {
            self.currentPoint = point;
        }
    }
    [self setNeedsDisplay];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@", self.slidingpath);
    NSString *slidingpath = self.slidingpath;
    
    // 代理回调
    if ([self.delegate respondsToSelector:@selector(gestureRecognitionView:slidingpath:)]) {
        [self.delegate gestureRecognitionView:self slidingpath:slidingpath];
    }
    // block回调
    if (self.gestureRecognitionViewSlidingpathBlock != NULL) {
        _gestureRecognitionViewSlidingpathBlock(self, slidingpath);
    }
    // 清空数组
    for (UIButton *btn in self.selectedBtns) {
        btn.selected = NO;
    }
//    [self.selectedBtns makeObjectsPerformSelector:@selector(setSelected:) withObject:@(NO)];
    [self.selectedBtns removeAllObjects];
    [self setNeedsDisplay];
}
// 滑过的轨迹
- (NSString *)slidingpath {
    NSMutableString *slidingpath = [NSMutableString string];
    for (UIButton *btn in self.selectedBtns) {
        [slidingpath appendFormat:@"%ld", (long)btn.tag];
    }
    return slidingpath;
}

- (void)drawRect:(CGRect)rect {
    
    if (!self.selectedBtns.count) return;
    
    
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    for (int i = 0; i < self.selectedBtns.count; i++) {
        UIView *view = self.selectedBtns[i];
        if (i == 0) {
            [bezierPath moveToPoint:view.center];
        } else {
            [bezierPath addLineToPoint:view.center];
        }
    }
//    CGRectEqualToRect(<#CGRect rect1#>, <#CGRect rect2#>)
//    CGPointEqualToPoint(<#CGPoint point1#>, <#CGPoint point2#>)
    
    [bezierPath addLineToPoint:self.currentPoint];
    
    bezierPath.lineWidth = 5;
    bezierPath.lineJoinStyle = kCGLineJoinBevel;
    [[UIColor greenColor] set];
    [bezierPath stroke];
    
}












@end
