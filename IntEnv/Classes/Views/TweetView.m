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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contraintTextLabelHeight;

@end

@implementation TweetView

+ (TweetView *)tweetViewWithIETweet:(IETweet *)tweet {
    // instead of using [NSBundle mainBundle] we use bundleForClass to let the unit test target create one of those TweetView objects by calling this class method
    TweetView * tweetView = [[[NSBundle bundleForClass:[TweetView class]] loadNibNamed:@"TweetView" owner:self options:nil] lastObject];
    [tweetView configureViewWithTweet:tweet];
    return tweetView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // once the view is resized, we draw the rounded corners and shadowpath
    [self.backGroundView drawRoundedRectWithCornerRadius:kCornerRadius shadowColor:[UIColor grayColor] shadowOffset:CGSizeMake(0, 0.5) shadowRadius:1.0];
}

- (void)configureViewWithTweet:(IETweet *)tweet {
    self.labelUserName.text = tweet.userName;
    self.labelTwitter.text = [@"@" stringByAppendingString:tweet.screenName];
    self.labelText.text = tweet.text;
    [self loadImageAsyncFromURL:[NSURL URLWithString:tweet.profileImageURL]];
    [self.labelText resizeToFitContents];
    self.contraintTextLabelHeight.constant = self.labelText.height;
    self.height = MAX(self.height, CGRectGetMaxY(self.labelText.frame) + kMinimumBottomMargin);
}

// the image is loaded asynchronously. It would be better to let the controller handle this, as views shouldn't lauch requests
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
