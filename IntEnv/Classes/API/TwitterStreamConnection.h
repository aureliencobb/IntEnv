//
//  TwitterStreetRequest.h
//  IntEnv
//
//  Created by Aurelien Cobb on 02/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@class TwitterStreamConnection;

@protocol TwitterStreamConnectionDelegate <NSObject>

- (void)twitterStreamConnection:(TwitterStreamConnection *)connection respondsWithTweets:(NSArray *)tweets;

@end

@interface TwitterStreamConnection : NSObject <NSURLConnectionDataDelegate>

+ (TwitterStreamConnection *)streamTweetsWithKeyword:(NSString *)keyword delegate:(id<TwitterStreamConnectionDelegate>)delegate;

- (void)startStreamingWithKeyword:(NSString *)aKeyword;

- (void)closeConnection;

@end



