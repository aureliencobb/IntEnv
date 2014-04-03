//
//  TwitterStreetRequest.m
//  IntEnv
//
//  Created by Aurelien Cobb on 02/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import "TwitterStreamConnection.h"
#import "IETweet.h"

@interface TwitterStreamConnection()

@property (strong, nonatomic) NSURLConnection * connection;
@property (weak, nonatomic) id<TwitterStreamConnectionDelegate> delegate;

@end

@implementation TwitterStreamConnection

+ (TwitterStreamConnection *)streamTweetsWithKeyword:(NSString *)keyword delegate:(id<TwitterStreamConnectionDelegate>)delegate {
    NSAssert(delegate != nil, @"the delegate can not be nil");
    TwitterStreamConnection * connection = [[TwitterStreamConnection alloc] init];
    connection.delegate = delegate;
    [connection startStreamingWithKeyword:keyword];
    return connection;
}

- (void)startStreamingWithKeyword:(NSString *)keyword {
    // Close an ongoing connection if any
    [self closeConnection];
    
    // We need to obtain the account instance for the user's Twitter account
    ACAccountStore *store = [[ACAccountStore alloc] init];
    ACAccountType *twitterAccountType = [store accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    //  Request permission from the user to access the available Twitter accounts
    [store requestAccessToAccountsWithType:twitterAccountType
                                   options:nil
                                completion:^(BOOL granted, NSError *error) {
        if (!granted) {
            // The user rejected your request
            NSLog(@"User rejected access to the account.");
        }
        else {
            // Grab the available accounts
            NSArray *twitterAccounts = [store accountsWithAccountType:twitterAccountType];
            if ([twitterAccounts count] > 0) {
                ACAccount *account = [twitterAccounts lastObject];
                NSURL *url = [NSURL URLWithString:@"https://stream.twitter.com/1.1/statuses/filter.json"];
                NSDictionary *params = @{@"track" : keyword};
                SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                        requestMethod:SLRequestMethodPOST
                                                                  URL:url
                                                           parameters:params];
                [request setAccount:account];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.connection = [NSURLConnection connectionWithRequest:[request preparedURLRequest] delegate:self];
                    [self.connection start];
                });
            }
        }
    }];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSArray * tweets = [dataString componentsSeparatedByString:@"\n"];
    NSError * error;
    NSMutableArray * tweetObjects = [[NSMutableArray alloc] initWithCapacity:[tweets count]];
    for (NSString * tweetJSONString in tweets) {
        error = nil;
        if (tweetJSONString.length > 1) {
            NSDictionary * jsonDict = [NSJSONSerialization JSONObjectWithData:[tweetJSONString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
            if (error) {
                // break out and notify delegate
                NSLog(@"Error parsing JSON: %@", error.localizedDescription);
                break;
            }
            IETweet * tweetObject = [MTLJSONAdapter modelOfClass:IETweet.class fromJSONDictionary:jsonDict error:&error];
            
            if (error) {
                // break out and notify delegate
                NSLog(@"Error parsing JSON: %@", error.localizedDescription);
                break;
            }
            if ([tweetObject validate:&error]) {
                [tweetObjects addObject:tweetObject];
            }
        }
    }
    if ([self.delegate respondsToSelector:@selector(twitterStreamConnection:respondsWithTweets:)]) {
        [self.delegate twitterStreamConnection:self respondsWithTweets:[tweetObjects copy]];
    }
}

- (void)closeConnection {
    if (self.connection != nil) {
        [self.connection cancel];
        self.connection = nil;
    }
}

- (void)dealloc {
    [self closeConnection];
}

@end
