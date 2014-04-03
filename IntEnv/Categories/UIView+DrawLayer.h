//
//  UIView+DrawLayer.h
//  IntEnv
//
//  Created by Aurelien Cobb on 03/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DrawLayer)

- (void)drawRoundedRectWithCornerRadius:(CGFloat)cornerRadius shadowColor:(UIColor *)shadowColor shadowOffset:(CGSize)offset shadowRadius:(CGFloat)shadowRadius;

@end
