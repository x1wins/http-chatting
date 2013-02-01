//
//  CommonUtil.h
//  ios-chatting
//
//  Created by Rhee Chang-Woo on 13. 2. 2..
//  Copyright (c) 2013년 Chang woo Rhee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonUtil : NSObject
+ (id) share;
- (NSString*) buildStringJsonWithDictionaly:(NSDictionary*)dic;
- (NSDictionary*) buildDictionaryJsonWithJsonString:(NSString*)jsonString;

@end
