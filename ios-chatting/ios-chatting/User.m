//
//  User.m
//  ios-chatting
//
//  Created by Rhee Chang-Woo on 13. 1. 10..
//  Copyright (c) 2013년 Chang woo Rhee. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize userid = _userid;
@synthesize username = _username;
@synthesize userPhotoUrl = _userPhotoUrl;

+ (id) setUserid:(NSString*)userid username:(NSString*)username userPhotoUrl:(NSString*)userPhotoUrl
{

    User *user = [[User alloc]init];
    user.userid = userid;
    user.username = username;
    if(userPhotoUrl==nil)
    {
        userPhotoUrl = @"http://i.i.com.com/cnwk.1d/i/tim/2012/02/15/iosAddressBook-300x300.png";
    }
    user.userPhotoUrl = userPhotoUrl;
    
    
    
    return user;
}

@end
