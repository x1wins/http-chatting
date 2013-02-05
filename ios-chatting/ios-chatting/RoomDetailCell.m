//
//  RoomDetailCell.m
//  ios-chatting
//
//  Created by Rhee Chang-Woo on 13. 2. 2..
//  Copyright (c) 2013년 Chang woo Rhee. All rights reserved.
//

#import "RoomDetailCell.h"
#import "MyInfo.h"
#import "CommonUtil.h"

@implementation RoomDetailCell

@synthesize userImage = _userImage;
@synthesize userName = _userName;
@synthesize message = _message;
@synthesize messageBgImage = _messageBgImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrameWithMessage:(Message *)message
{
    _message.text = message.content;
    _userName.text = [NSString stringWithFormat:@"%@", message.user.userid];
    
    _message.frame = CGRectMake(_message.frame.origin.x, _message.frame.origin.y, _message.frame.size.width, message.textHeight);
    [_message setNumberOfLines:0];
    [_message setLineBreakMode:NSLineBreakByWordWrapping];
    
    _messageBgImage.frame = CGRectMake(_messageBgImage.frame.origin.x, _messageBgImage.frame.origin.y, _messageBgImage.frame.size.width, message.bgHeight);
    
    
    NSString *bubbleImageName;
    NSString *myUserid = [[MyInfo share] userid];
    NSString *userid = [NSString stringWithFormat:@"%@", message.user.userid];
    if(![myUserid isEqualToString:userid])
    {
        bubbleImageName = @"MessageBubbleGray";
    }
    else
    {
        bubbleImageName = @"MessageBubbleBlue";
    }
    UIImage *messageBubbleImg = [[UIImage imageNamed:bubbleImageName] stretchableImageWithLeftCapWidth:23 topCapHeight:15];
    _messageBgImage.image = messageBubbleImg;
    
    NSURL *userImageUrl = [NSURL URLWithString:message.user.userPhotoUrl];

    UIImage *userImage = [[[CommonUtil share] storageImage] objectForKey:message.user.userPhotoUrl];
    
    if(userImage == nil)
    {
        [[CommonUtil share] loadAsyncImageFromURL:userImageUrl imageBlock:^(UIImage *image){
            
            _userImage.image = image;
            [[[CommonUtil share] storageImage] setObject:image forKey:message.user.userPhotoUrl];
            
        }errorBlock:^{
            
        }];
    }
    else
    {
        _userImage.image = userImage;
    }
    
}


@end
