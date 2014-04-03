//
//  TweetView.h
//  IntEnv
//
//  Created by Aurelien Cobb on 03/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IETweet;

/**
 *  The tweet view that displays some of the tweet information.
 */

@interface TweetView : UIView

/** Creates the TweetView with the given IETweet object */
+ (TweetView *)tweetViewWithIETweet:(IETweet *)tweet;

@end
