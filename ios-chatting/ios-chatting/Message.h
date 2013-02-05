//
//  Message.h
//  ios-chatting
//
//  Created by Rhee Chang-Woo on 13. 1. 10..
//  Copyright (c) 2013년 Chang woo Rhee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Message : NSObject

@property (assign, nonatomic) SInt64 roomid;
@property (assign, nonatomic) SInt64 messageid;
@property (strong, nonatomic) User *user;
@property (strong, nonatomic) NSString *imgUrl;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *date;
@property (assign, nonatomic) int cellHeight;
@property (assign, nonatomic) int textHeight;
@property (assign, nonatomic) int bgHeight;

+ (id) setRoomid:(SInt64)roomid messageid:(SInt64)messageid user:(User*)user imgUrl:(NSString *)imgUrl content:(NSString *)content date:(NSString *)date;

@end
