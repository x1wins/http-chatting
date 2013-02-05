//
//  MyInfo.m
//  ios-chatting
//
//  Created by Rhee Chang-Woo on 13. 2. 3..
//  Copyright (c) 2013년 Chang woo Rhee. All rights reserved.
//

#import "MyInfo.h"

@implementation MyInfo

@synthesize userid = _userid;
@synthesize username = _username;

+ (id) share {
    static MyInfo *singleton = nil;
    
    if(singleton == nil) {
        @synchronized(self) {
            if(singleton == nil) {
                singleton = [[self alloc] init];
                
            }
        }
    }
    
    return singleton;
}

- (void) setUserid:(NSString*)userid username:(NSString*)username
{
    _userid = userid;
    _username = username;
}

@end
