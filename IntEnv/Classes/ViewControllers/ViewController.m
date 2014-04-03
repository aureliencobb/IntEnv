//
//  ViewController.m
//  IntEnv
//
//  Created by Aurelien Cobb on 02/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import "ViewController.h"
#import "TwitterStreamConnection.h"
#import "TweetStreamScrollView.h"

@interface ViewController () <TwitterStreamConnectionDelegate>

@property (weak, nonatomic) IBOutlet TweetStreamScrollView *twitterStreamScrollView;
@property (strong, nonatomic) TwitterStreamConnection * twitterConnection;
/** NSArray for the table data source. Holds objects of type `IETweet` */
@property (copy, nonatomic) NSMutableArray * tweets;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.twitterConnection = [TwitterStreamConnection streamTweetsWithKeyword:@"banking" delegate:self];
}

- (void)closeTwitterConnection {
    [self.twitterConnection closeConnection];
}

#pragma mark - TwitterStreamConnectionDelegate methods

- (void)twitterStreamConnection:(TwitterStreamConnection *)connection respondsWithTweets:(NSArray *)tweets {
    for (id tweet in tweets) {
        [self.twitterStreamScrollView addTweet:tweet];
    }
}

@end
