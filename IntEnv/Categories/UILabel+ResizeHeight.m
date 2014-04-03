//
//  UILabel+ResizeHeight.m
//  IntEnv
//
//  Created by Aurelien Cobb on 03/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import "UILabel+ResizeHeight.h"

@implementation UILabel (ResizeHeight)

- (void)resizeToFitContents {
    CGRect bounds = self.boundsThatFitContents;
    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(bounds), CGRectGetHeight(bounds));
}

- (CGRect)boundsThatFitContents {
    self.numberOfLines = 0;
    self.lineBreakMode = NSLineBreakByWordWrapping;
    self.backgroundColor = [UIColor greenColor];
    NSDictionary *attributes = @{NSFontAttributeName:self.font};
    CGRect bounds = [self.text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return bounds;
}

@end
