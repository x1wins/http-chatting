//
//  CommonUtil.m
//  ios-chatting
//
//  Created by Rhee Chang-Woo on 13. 2. 2..
//  Copyright (c) 2013년 Chang woo Rhee. All rights reserved.
//

#import "CommonUtil.h"
#import "Message.h"

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

- (int) heightWithText:(NSString*)text font:(UIFont*)font
{
    CGSize  sizeTemp = CGSizeMake(218.0f, 2000.0f);
    CGSize labelSize = [text sizeWithFont:font constrainedToSize:sizeTemp lineBreakMode:NSLineBreakByWordWrapping];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, labelSize.width, labelSize.height)];
    label.text = text;
    label.font = font;
    
    return labelSize.height;
}


- (NSArray*) messagesWithResponseStr:(NSString*)responseStr
{
    NSDictionary *dataDic = [[CommonUtil share] buildDictionaryJsonWithJsonString:responseStr];
    
    NSArray *results = [NSMutableArray arrayWithArray:[[dataDic objectForKey:@"res"] objectForKey:@"result"]];
    
    NSMutableArray *datas = [[NSMutableArray alloc]init];
    for (int i = 0; i < [results count]; i++)
    {
        NSDictionary *dic = [results objectAtIndex:i];
        NSString *messageid = [dic objectForKey:@"id"];
        SInt64 userid    = [[dic objectForKey:@"userid"] longLongValue];
        NSString *username  = nil;//[dic objectForKey:@"userid"];
        NSString *imgUrl    = nil;
        NSString *content   = [dic objectForKey:@"content"];
        NSString *date      = nil;
        [datas addObject:[Message setMessageid:messageid userid:userid username:username imgUrl:imgUrl content:content date:date]];
    }
    return datas;
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
