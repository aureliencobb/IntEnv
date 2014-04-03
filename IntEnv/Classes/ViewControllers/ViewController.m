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

NSString * const kSearchWord = @"banking";

@interface ViewController () <TwitterStreamConnectionDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet TweetStreamScrollView *twitterStreamScrollView;
@property (strong, nonatomic) TwitterStreamConnection * twitterConnection;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *labelConnectionStatus;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [@"10 latest tweets for " stringByAppendingString:kSearchWord];
    self.twitterStreamScrollView.scrollIndicatorInsets = self.twitterStreamScrollView.contentInset;
    [self launchTwitterConnection];
}

- (void)launchTwitterConnection {
    [self.activityIndicator startAnimating];
    self.labelConnectionStatus.hidden = NO;
    self.twitterConnection = [TwitterStreamConnection streamTweetsWithKeyword:kSearchWord delegate:self];
}

- (void)closeTwitterConnection {
    [self.twitterConnection closeConnection];
}

#pragma mark - TwitterStreamConnectionDelegate methods

- (void)twitterStreamConnection:(TwitterStreamConnection *)connection respondsWithTweets:(NSArray *)tweets {
    [self.activityIndicator removeFromSuperview];
    [self.labelConnectionStatus removeFromSuperview];
    for (id tweet in tweets) {
        [self.twitterStreamScrollView addTweet:tweet];
    }
}

- (void)twitterStreamConnection:(TwitterStreamConnection *)connection didFailWithError:(NSError *)error {
    [self.activityIndicator stopAnimating];
    self.labelConnectionStatus.hidden = NO;
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Retry", nil];
    [alertView show];
}

#pragma mark - UIAlertViewDelegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            exit(1);
            break;
        case 1:
            [self launchTwitterConnection];
        default:
            break;
    }
}

@end
