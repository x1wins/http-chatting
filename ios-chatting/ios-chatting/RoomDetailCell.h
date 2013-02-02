//
//  RoomDetailCell.h
//  ios-chatting
//
//  Created by Rhee Chang-Woo on 13. 2. 2..
//  Copyright (c) 2013년 Chang woo Rhee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"

@interface RoomDetailCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *userImage;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *message;
@property (strong, nonatomic) IBOutlet UIImageView *messageBgImage;


- (void)setFrameWithMessage:(Message *)message;

@end
