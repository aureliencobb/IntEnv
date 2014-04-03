//
//  TweetStreamScrollView.m
//  IntEnv
//
//  Created by Aurelien Cobb on 03/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import "TweetStreamScrollView.h"
#import "IETweet.h"
#import "TweetView.h"
#import "UIView+Geometry.h"

const NSUInteger kDefaultNumberOfTweetViews = 10;
const CGFloat kDefaultNewTweetAnimationDutation = 0.2;

@interface TweetStreamScrollView()

// Dequeue holding TweetView objects
@property (strong, nonatomic) NSMutableArray * tweetViews;

@end

@implementation TweetStreamScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configureSelf];
    }
    return self;
}

- (void)awakeFromNib {
    [self configureSelf];
}

- (void)configureSelf {
    self.maxItems = kDefaultNumberOfTweetViews;
}

- (NSMutableArray *)tweetViews {
    if (!_tweetViews) {
        _tweetViews = [[NSMutableArray alloc] initWithCapacity:self.maxItems];
    }
    return _tweetViews;
}

- (TweetView *)tweetViewWithIETweet:(IETweet *)tweet {
    return [TweetView tweetViewWithIETweet:tweet];
}

// we add a tweet to a dequeue, making sure that no more than the maximum number is exceeded.
// latest tweets are added at the top
- (void)addTweet:(IETweet *)tweet {
    if (![tweet isKindOfClass:[IETweet class]]) {
        return;
    }
    
    // the tweet need to be invisible for now. it only becomes visible when all other tweets have moved down.
    TweetView * tweetView = [self tweetViewWithIETweet:tweet];
    tweetView.x = (self.width - tweetView.width) / 2;
    tweetView.alpha = 0.0;
    
    [self.tweetViews insertObject:tweetView atIndex:0];
    
    // lets remove old tweets
    if ([self.tweetViews count] > self.maxItems) {
        TweetView * lastTweetView = [self.tweetViews lastObject];
        [lastTweetView removeFromSuperview];
        [self.tweetViews removeObject:lastTweetView];
    }
    [self moveOlderTweetsDownForNewTweet:tweetView];
}

- (void)moveOlderTweetsDownForNewTweet:(TweetView *)tweetView {
    __block CGFloat yPos = 0.0;
    [UIView animateWithDuration:kDefaultNewTweetAnimationDutation animations:^{
        for (TweetView * tweetView in self.tweetViews) {
            tweetView.y = yPos;
            yPos += tweetView.height;
        }
    } completion:^(BOOL finished) {
        [self addSubview:tweetView];
        [UIView animateWithDuration:kDefaultNewTweetAnimationDutation animations:^{
            tweetView.alpha = 1.0;
        }];

    }];
    self.contentSize = CGSizeMake(self.width, yPos);
}

@end
