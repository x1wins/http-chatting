//
//  CommonUtil.h
//  ios-chatting
//
//  Created by Rhee Chang-Woo on 13. 2. 2..
//  Copyright (c) 2013년 Chang woo Rhee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonUtil : NSObject

@property (strong, nonatomic) NSMutableDictionary *storageImage;

+ (id) share;
- (void) loadAsyncImageFromURL:(NSURL *)url  imageBlock:(void (^) (UIImage *image))imageBlock errorBlock:(void(^)(void))errorBlock;
- (void) bulidErrorView:(UIViewController*)viewController;
- (void) bulidCloseButton:(UIViewController*)viewController sel:(SEL)method;
- (void) bulidNavigationRightRefreshButton:(UIViewController*)viewController sel:(SEL)method;
- (int) heightWithText:(NSString*)text font:(UIFont*)font;
- (NSArray*) messagesWithResponseStr:(NSString*)results;
- (NSString*) buildStringJsonWithDictionaly:(NSDictionary*)dic;
- (NSDictionary*) buildDictionaryJsonWithJsonString:(NSString*)jsonString;
- (void) buildErrorView:(UIViewController*)viewController jsonString:(NSString*)jsonString;

@end
