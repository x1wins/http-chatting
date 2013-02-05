//
//  Message.m
//  ios-chatting
//
//  Created by Rhee Chang-Woo on 13. 1. 10..
//  Copyright (c) 2013년 Chang woo Rhee. All rights reserved.
//

#import "Message.h"
#import "CommonUtil.h"

@class RoomDetailCell;

@implementation Message

@synthesize roomid = _roomid;
@synthesize messageid = _messageid;
@synthesize user = _user;
@synthesize imgUrl = _imgUrl;
@synthesize content = _content;
@synthesize date = _date;
@synthesize cellHeight = _cellHeight;

+ (id) setRoomid:(SInt64)roomid messageid:(SInt64)messageid user:(User*)user imgUrl:(NSString *)imgUrl content:(NSString *)content date:(NSString *)date
{
    Message *message = [[Message alloc]init];
    message.roomid = roomid;
    message.messageid = messageid;
    message.user = user;
    message.imgUrl = imgUrl;
    message.content = content;
    message.date = date;
    
    int textHeight = [[CommonUtil share] heightWithText:message.content font:[UIFont systemFontOfSize:17]];
    int plusHeight = 0;
    
    if(textHeight>21)
    {
        plusHeight = textHeight-21;
    }
    
    int height = 100 + plusHeight;
    int bgHeight = 61 + plusHeight;
    
    message.bgHeight = bgHeight;
    message.textHeight = textHeight;
    message.cellHeight = height;
    
    return message;
}

@end
