//
//  RoomListViewController.h
//  ios-chatting
//
//  Created by Rhee Chang-Woo on 13. 2. 2..
//  Copyright (c) 2013년 Chang woo Rhee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoomListViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic) NSMutableArray *datas;

@end
