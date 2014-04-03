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

/**
 *  The TwitterStreamConnection object launches the NSURLConnection and keeps it open to receive the stream of tweets.
 *  It uses the user's Account details on the device.
 *  Destroying the object cancels the connection
 */

@class TwitterStreamConnection;

/**
 *  The protocol to inform the delegate of the incoming stream or any errors encountered
 */
@protocol TwitterStreamConnectionDelegate <NSObject>

/** Send an array of IETweet objects to the delegate */
- (void)twitterStreamConnection:(TwitterStreamConnection *)connection respondsWithTweets:(NSArray *)tweets;

/** Inform the delegate of an error that occoured. The connection is canceled */
- (void)twitterStreamConnection:(TwitterStreamConnection *)connection didFailWithError:(NSError *)error;

@end

@interface TwitterStreamConnection : NSObject <NSURLConnectionDataDelegate>

/** Create the connection object. Omitting the delegate will throw an exeption */
+ (TwitterStreamConnection *)streamTweetsWithKeyword:(NSString *)keyword delegate:(id<TwitterStreamConnectionDelegate>)delegate;

/** Open an NSURLConnection and closes any previous connection in progress. */
- (void)startStreamingWithKeyword:(NSString *)aKeyword;

/** Cancels the NSURLConnection */
- (void)closeConnection;

@end



