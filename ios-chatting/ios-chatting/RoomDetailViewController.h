//
//  RoomDetailViewController.h
//  ios-chatting
//
//  Created by Rhee Chang-Woo on 13. 2. 2..
//  Copyright (c) 2013년 Chang woo Rhee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoomDetailViewController : UIViewController
{
    CGRect _initKeypadRect;
    CGFloat _keyboardHeight;
}
@property (strong, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic) NSMutableArray *datas;
@property (assign, nonatomic) SInt64 roomId;

//keypad
@property (retain, nonatomic) IBOutlet UIView *keypad;
@property (retain, nonatomic) IBOutlet UITextView *textView;

@end
