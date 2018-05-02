//
//  UIView+Frame.m
//  商速老板助手
//
//  Created by 赵宁 on 2018/5/2.
//  Copyright © 2018年 luyonghao. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void)setX:(CGFloat)x{
    self.frame = CGRectMake(x, self.y, self.width, self.height);
}

- (CGFloat)x{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y{
    self.frame = CGRectMake(self.x, y, self.width, self.height);
}

- (CGFloat)y{
    return self.frame.origin.x;
}

- (void)setWidth:(CGFloat)width{
    self.frame = CGRectMake(self.x, self.y, width, self.height);
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height{
    self.frame = CGRectMake(self.x, self.y, self.width, height);
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setCenterX:(CGFloat)centerX{
    self.center = CGPointMake(centerX, self.centerY);
}

- (CGFloat)centerX{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY{
    self.center = CGPointMake(self.centerX, centerY);
}

- (CGFloat)centerY{
    return self.center.y;
}

- (void)setRightX:(CGFloat)rightX{
    self.frame = CGRectMake(rightX-self.width, self.y, self.width, self.height);
}

- (CGFloat)rightX{
    return self.width+self.x;
}

- (void)setBottomY:(CGFloat)bottomY{
    self.frame = CGRectMake(self.x, bottomY-self.height, self.width, self.height);
}

- (CGFloat)bottomY{
    return self.height+self.y;
}
@end
