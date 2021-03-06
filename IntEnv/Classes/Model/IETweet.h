//
//  IETweet.h
//  IntEnv
//
//  Created by Aurelien Cobb on 02/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"

/** 
 *  The Model, subclass of MTLModel to get the mapping, hashing, json serialization and desctiption for free.
 */

@interface IETweet : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic) NSString * text;
@property (copy, nonatomic) NSString * userName;
@property (copy, nonatomic) NSString * screenName;
@property (copy, nonatomic) NSString * profileImageURL;

@end
