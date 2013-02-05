//
//  MyInfo.h
//  ios-chatting
//
//  Created by Rhee Chang-Woo on 13. 2. 3..
//  Copyright (c) 2013년 Chang woo Rhee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyInfo : NSObject

@property (strong, nonatomic) NSString *userid;
@property (strong, nonatomic) NSString *username;

+ (id) share;
- (void) setUserid:(NSString*)userid username:(NSString*)username;

@end
