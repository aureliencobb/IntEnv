//
//  TweetStreamScrollViewTests.m
//  IntEnv
//
//  Created by Aurelien Cobb on 03/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TweetStreamScrollView.h"
#import "IETweet.h"
#import "TweetView.h"


@interface TweetStreamScrollView (UnitTest)
- (NSMutableArray *)tweetViews;
-(TweetView *) tweetViewWithIETweet:(IETweet *) tweet;
@end

@interface TweetStreamScrollViewTests : XCTestCase {
    TweetStreamScrollView * _tweetScrollView;
}

@end

@implementation TweetStreamScrollViewTests

- (void)setUp {
    [super setUp];
    _tweetScrollView = [[TweetStreamScrollView alloc] initWithFrame:CGRectZero];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testTweetScrollViewCreated {
    XCTAssertNotNil(_tweetScrollView, @"Failed to create the tweet scrollview");
}

- (void)testThatTweetsArrayIsNotNil {
    XCTAssertNotNil(_tweetScrollView.tweetViews, @"TweetViews array can not be nil");
}

- (void)testAddingTweetHandlesWrongClass {
    NSUInteger numberOfTweets = [_tweetScrollView.tweetViews count];
    id obj = [NSString string];
    [_tweetScrollView addTweet:obj];
    NSUInteger newNumberOfTweets = [_tweetScrollView.tweetViews count];
    XCTAssertEqual(numberOfTweets, newNumberOfTweets, @"Adding tweets should be of type IETweet class");
}

- (void)testAddingTweetIncrementsByOne {
    IETweet * tweet = [[IETweet alloc] init];
    NSUInteger numberOfTweets = [_tweetScrollView.tweetViews count];
    [_tweetScrollView addTweet:tweet];
    NSUInteger newNumberOfTweets = [_tweetScrollView.tweetViews count];
    XCTAssertEqual(numberOfTweets + 1, newNumberOfTweets, @"Adding tweets should increment the number by 1");
}

- (void)testThatNoMoreThanMaxNumberOfTweetViewsArePresent {
    for (int i = 0; i <= _tweetScrollView.maxItems; i++) {
        IETweet * tweet = [[IETweet alloc] init];
        [_tweetScrollView addTweet:tweet];
    }
    XCTAssertEqual(_tweetScrollView.maxItems, [_tweetScrollView.tweetViews count], @"There should be a maximum of %d objects", _tweetScrollView.maxItems);
}

@end
