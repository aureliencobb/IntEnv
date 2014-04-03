//
//  UIView+Geometry.m
//  IntEnv
//
//  Created by Aurelien Cobb on 03/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import "UIView+Geometry.h"

@implementation UIView (Geometry)

- (CGFloat)x {
    return CGRectGetMinX(self.frame);
}

- (void)setX:(CGFloat)x {
    self.frame = CGRectIntegral(CGRectMake(x, CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)));
}

- (CGFloat)y {
    return CGRectGetMinY(self.frame);
}

- (void)setY:(CGFloat)y {
    self.frame = CGRectIntegral(CGRectMake(CGRectGetMinX(self.frame), y, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)));
}

- (CGFloat)width {
    return CGRectGetWidth(self.frame);
}

- (void)setWidth:(CGFloat)width {
    self.frame = CGRectIntegral(CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), width, CGRectGetHeight(self.frame)));
}

- (CGFloat)height {
    return CGRectGetHeight(self.frame);
}

- (void)setHeight:(CGFloat)height {
    self.frame = CGRectIntegral(CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), height));
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    self.frame = CGRectIntegral(CGRectMake(origin.x, origin.y, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)));
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    self.frame = CGRectIntegral(CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), size.width, size.height));
}

@end
