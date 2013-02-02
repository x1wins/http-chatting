//
//  Message.h
//  ios-chatting
//
//  Created by Rhee Chang-Woo on 13. 1. 10..
//  Copyright (c) 2013년 Chang woo Rhee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property (strong, nonatomic) NSString *messageid;
@property (assign, nonatomic) SInt64 userid;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *imgUrl;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *date;
@property (assign, nonatomic) int cellHeight;
@property (assign, nonatomic) int textHeight;
@property (assign, nonatomic) int bgHeight;

+ (id) setMessageid:(NSString*)messageid userid:(SInt64)userid username:(NSString *)username imgUrl:(NSString *)imgUrl content:(NSString *)content date:(NSString *)date;

@end
