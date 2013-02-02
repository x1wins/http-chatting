//
//  RoomDetailViewController.m
//  ios-chatting
//
//  Created by Rhee Chang-Woo on 13. 2. 2..
//  Copyright (c) 2013년 Chang woo Rhee. All rights reserved.
//

#import "RoomDetailViewController.h"

#import "common/CommonConst.h"
#import "common/CommonUtil.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"

#import "RoomDetailCell.h"
#import "Message.h"

@interface RoomDetailViewController ()

@end

@implementation RoomDetailViewController

@synthesize roomId = _roomId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.datas = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self reloadDatas];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - request to server
- (void) reloadDatas
{
    
    NSString *path = [NSString stringWithFormat:@"chat/message/find/%lld",_roomId];
    NSString *strUrl = [NSString stringWithFormat:SERVER_URL_HTTP,path];
    
    NSURL *url = [NSURL URLWithString:strUrl];
    AFHTTPClient *client = [[AFHTTPClient alloc]initWithBaseURL:url];
    
    //depending on what kind of response you expect.. change it if you expect XML
    [client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    [client getPath:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"success");
        NSLog(@"Request Successful, response '%@'", responseStr);
        
        _datas = [NSMutableArray arrayWithArray:[[CommonUtil share] messagesWithResponseStr:responseStr]];
        
        [_mainTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure");
        NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
    }];
    
}

#pragma mark - table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    int cell_count = [_datas count];
    return cell_count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"RoomDetailCell";
    
    RoomDetailCell *cell = (RoomDetailCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    
    if (cell == nil)
    {
        cell = [[RoomDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"RoomDetailCell" owner:nil options:nil];
        cell = [array objectAtIndex:0];
        
    }
    
    Message *message = [_datas objectAtIndex:indexPath.row];
    
    [cell setFrameWithMessage:message];

    // Configure the cell...
    cell.selectionStyle = NO;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *) indexPath{
    
    Message *message = [_datas objectAtIndex:indexPath.row];
    NSLog(@"message.cellHeight %d",message.cellHeight);
    int height = message.cellHeight;
    return height;
}


@end
