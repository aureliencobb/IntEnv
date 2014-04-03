//
//  TweetView.m
//  IntEnv
//
//  Created by Aurelien Cobb on 03/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import "TweetView.h"
#import "UILabel+ResizeHeight.h"
#import "UIView+DrawLayer.h"
#import "UIView+Geometry.h"
#import "IETweet.h"

const CGFloat kCornerRadius = 10.0;
const CGFloat kMinimumBottomMargin = 6.0;

@interface TweetView()

@property (weak, nonatomic) IBOutlet UIView *backGroundView;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *labelUserName;
@property (weak, nonatomic) IBOutlet UILabel *labelTwitter;
@property (weak, nonatomic) IBOutlet UILabel *labelText;

@end

@implementation TweetView

+ (TweetView *)tweetViewWithIETweet:(IETweet *)tweet {
    TweetView * tweetView = [[[NSBundle bundleForClass:[TweetView class]] loadNibNamed:@"TweetView" owner:self options:nil] lastObject];
    [tweetView configureViewWithTweet:tweet];
    return tweetView;
}

- (void)configureViewWithTweet:(IETweet *)tweet {
    self.labelUserName.text = tweet.userName;
    self.labelTwitter.text = tweet.screenName;
    self.labelText.text = tweet.text;
    [self loadImageAsyncFromURL:[NSURL URLWithString:tweet.profileImageURL]];
    [self.labelText resizeToFitContents];
    self.height = MAX(self.height, CGRectGetMaxY(self.labelText.frame) + kMinimumBottomMargin);
    [self.backGroundView drawRoundedRectWithCornerRadius:kCornerRadius shadowColor:[UIColor blackColor] shadowOffset:CGSizeMake(0, 1) shadowRadius:1];
}

- (void)loadImageAsyncFromURL:(NSURL *)url {
    if (url == nil) {
        return;
    }
    dispatch_queue_t imageLoadingQueue = dispatch_queue_create("imageLoadingQueue", NULL);
    dispatch_async(imageLoadingQueue, ^{
        NSData * imageData = [NSData dataWithContentsOfURL:url];
        UIImage * image = [UIImage imageWithData:imageData];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.userImage.image = image;
        });
    });
}

@end
