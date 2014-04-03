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

- (void)addTweet:(IETweet *)tweet {
    if (![tweet isKindOfClass:[IETweet class]]) {
        return;
    }
    TweetView * tweetView = [self tweetViewWithIETweet:tweet];
    
    [self.tweetViews insertObject:tweetView atIndex:0];
    if ([self.tweetViews count] > self.maxItems) {
        [self.tweetViews removeLastObject];
    }
    [self moveOlderTweetsDown];
    [self addSubview:tweetView];
}

- (void)moveOlderTweetsDown {
    __block CGFloat yPos = 0.0;
    [UIView animateWithDuration:0.3 animations:^{
        for (TweetView * tweetView in self.tweetViews) {
            tweetView.y = yPos;
            yPos += tweetView.height;
        }
    }];
    self.contentSize = CGSizeMake(self.width, yPos);
}

@end
