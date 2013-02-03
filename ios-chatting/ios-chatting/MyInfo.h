//
//  MyInfo.h
//  ios-chatting
//
//  Created by Rhee Chang-Woo on 13. 2. 3..
//  Copyright (c) 2013년 Chang woo Rhee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyInfo : NSObject

@property (assign, nonatomic) SInt64 userid;
@property (strong, nonatomic) NSString *username;

+ (id) share;
- (void) setUserid:(SInt64)userid username:(NSString*)username;

@end
