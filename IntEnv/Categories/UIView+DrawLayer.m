//
//  UIView+DrawLayer.m
//  IntEnv
//
//  Created by Aurelien Cobb on 03/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import "UIView+DrawLayer.h"

@implementation UIView (DrawLayer)

- (void)drawRoundedRectWithCornerRadius:(CGFloat)cornerRadius shadowColor:(UIColor *)shadowColor shadowOffset:(CGSize)offset shadowRadius:(CGFloat)shadowRadius {
    CALayer * layer = self.layer;
    layer.cornerRadius = cornerRadius;
    layer.shadowColor = shadowColor.CGColor;
    layer.shadowOffset = offset;
    layer.shadowRadius = shadowRadius;
    layer.shadowOpacity = 1.0;
    CGRect shadowFrame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:shadowFrame cornerRadius:cornerRadius];
    [layer setShadowPath:path.CGPath];
}

@end
