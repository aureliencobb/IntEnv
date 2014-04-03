//
//  TweetStreamScrollView.h
//  IntEnv
//
//  Created by Aurelien Cobb on 03/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IETweet;

@interface TweetStreamScrollView : UIScrollView

/** A method to add a IETweet object. If the number of objects exceeds maxItems, the oldest object is removed */
- (void)addTweet:(IETweet *)tweet;

/** Sets the maximum number of views in the TweetStreamScrollView. The default is 10 */
@property (assign, nonatomic) NSUInteger maxItems;

@end
