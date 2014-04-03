//
//  IETweet.m
//  IntEnv
//
//  Created by Aurelien Cobb on 02/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import "IETweet.h"

@implementation IETweet

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"text" : @"text",
             @"userName" : @"user.name",
             @"screenName" : @"user.screen_name",
             @"profileImage" : @"user.profile_background_image_url"};
}

- (NSString *)description {
    return [NSString stringWithFormat:@"{"
            "\rtext: %@"
            "\ruserName: %@"
            "\rscreenName: %@"
            "\rimage URL: %@",
            self.text,
            self.userName,
            self.screenName,
            self.profileImageURL];
}

@end
