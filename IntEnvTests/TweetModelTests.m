//
//  TweetModelTests.m
//  IntEnv
//
//  Created by Aurelien Cobb on 03/04/2014.
//  Copyright (c) 2014 Aurelien Cobb. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "IETweet.h"

@interface TweetModelTests : XCTestCase

@end

@implementation TweetModelTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void)testValidityOfUserNameInIETweetModel {
    BOOL valid = NO;
    NSError * error;
    IETweet * tweet = [MTLJSONAdapter modelOfClass:IETweet.class fromJSONDictionary:@{@"text": @"Hello First Tweet"} error:nil];
    valid = [tweet validate:&error];
    XCTAssertFalse(valid, @"A tweet must have a username, screenname and text");
}

@end
