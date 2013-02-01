//
//  CommonUtil.m
//  ios-chatting
//
//  Created by Rhee Chang-Woo on 13. 2. 2..
//  Copyright (c) 2013년 Chang woo Rhee. All rights reserved.
//

#import "CommonUtil.h"

@implementation CommonUtil


+ (id) share {
    static CommonUtil *singleton = nil;
    
    if(singleton == nil) {
        @synchronized(self) {
            if(singleton == nil) {
                singleton = [[self alloc] init];
            }
        }
    }
    
    return singleton;
}

/**
 =====================================================================
 NSString <-> NSData <-> NSDcitionarty
 =====================================================================
 **/

- (NSString*) buildStringJsonWithDictionaly:(NSDictionary*)dic
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *jsonString;
    if (! jsonData)
    {
        NSLog(@"Got an error: %@", error);
    }
    else
    {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    return jsonString;
}

- (NSDictionary*) buildDictionaryJsonWithJsonString:(NSString*)jsonString
{
    NSError *error;
    
    NSDictionary *jsonDic =
    [NSJSONSerialization JSONObjectWithData: [jsonString dataUsingEncoding:NSUTF8StringEncoding]
                                    options: NSJSONReadingMutableContainers
                                      error: &error];
    
    return jsonDic;
}

@end
