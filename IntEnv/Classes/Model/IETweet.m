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
             @"profileImageURL" : @"user.profile_background_image_url"};
}

-(BOOL)validateValue:(inout __autoreleasing id *)ioValue forKey:(NSString *)inKey error:(out NSError *__autoreleasing *)outError {
    if ([inKey isEqualToString:@"profileImageURL"]) {
        return YES;
    }
    return *ioValue != nil;
}

@end
