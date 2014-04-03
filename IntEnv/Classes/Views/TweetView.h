//
//  TweetView.h
//  IntEnv
//
//  Created by Aurelien Cobb on 03/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IETweet;

@interface TweetView : UIView

+ (TweetView *)tweetViewWithIETweet:(IETweet *)tweet;

@end
