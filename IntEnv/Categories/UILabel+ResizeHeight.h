//
//  UILabel+ResizeHeight.h
//  IntEnv
//
//  Created by Aurelien Cobb on 03/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Resize a multiline UILabel 
 */

@interface UILabel (ResizeHeight)

- (void)resizeToFitContents;

@property (assign, nonatomic, readonly) CGRect boundsThatFitContents;

@end
