//
//  Message.h
//  ios-chatting
//
//  Created by Rhee Chang-Woo on 13. 1. 10..
//  Copyright (c) 2013년 Chang woo Rhee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property (strong, nonatomic) NSString *userid;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSString *date;

@end
