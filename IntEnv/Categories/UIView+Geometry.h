//
//  UIView+Geometry.h
//  IntEnv
//
//  Created by Aurelien Cobb on 03/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 
 *  This Category offers shortcuts to manipulte the view's frame
 */

@interface UIView (Geometry)

/** A shortcut to view.frame.origin.x */
@property (nonatomic) CGFloat x;
/** A shortcut to view.frame.origin.y */
@property (nonatomic) CGFloat y;
/** A shortcut to view.frame.size.width */
@property (nonatomic) CGFloat width;
/** A shortcut to view.frame.size.height */
@property (nonatomic) CGFloat height;
/** A shortcut to view.frame.origin */
@property (nonatomic) CGPoint origin;
/** A shortcut to view.frame.size */
@property (nonatomic) CGSize size;

@end
