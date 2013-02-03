//
//  RoomListViewController.m
//  ios-chatting
//
//  Created by Rhee Chang-Woo on 13. 2. 2..
//  Copyright (c) 2013년 Chang woo Rhee. All rights reserved.
//

#import "RoomListViewController.h"

#import "common/CommonConst.h"
#import "common/CommonUtil.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"

#import "RoomDetailViewController.h"
#import "Message.h"

#import "MBProgressHUD.h"

@interface RoomListViewController ()

@end

@implementation RoomListViewController

@synthesize datas = _datas;

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

#pragma mark - my Function
- (void) reloadDatas
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *strUrl = [NSString stringWithFormat:SERVER_URL_HTTP,@"chat/room/find"];
    
    NSURL *url = [NSURL URLWithString:strUrl];
    AFHTTPClient *client = [[AFHTTPClient alloc]initWithBaseURL:url];
    
    //depending on what kind of response you expect.. change it if you expect XML
    [client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    [client getPath:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"success");
        NSLog(@"Request Successful, response '%@'", responseStr);
        
        NSDictionary *dataDic = [[CommonUtil share] buildDictionaryJsonWithJsonString:responseStr];
        [_datas removeAllObjects];
        _datas = [NSMutableArray arrayWithArray:[[dataDic objectForKey:@"res"] objectForKey:@"result"]];
    
        [_mainTableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure");
        NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [[CommonUtil share] bulidErrorView:self];
    }];

}

#pragma mark - getter

- (NSString*) roomSubjectWithIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [_datas objectAtIndex:indexPath.row];
    NSString *subject = [dic objectForKey:@"subject"];
    
    return subject;
}

- (SInt64) roomIdWithIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [_datas objectAtIndex:indexPath.row];
    SInt64 roomId = [[dic objectForKey:@"id"] longLongValue];
    
    return roomId;
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
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *dic = [_datas objectAtIndex:indexPath.row];
    NSString *subject = [dic objectForKey:@"subject"];
    
    cell.textLabel.text = subject;
    
    // Configure the cell...
    cell.selectionStyle = YES;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *) indexPath{
    
    int height = 50;
    return height;
}


//cell click event
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RoomDetailViewController *roomDetailViewController = [[RoomDetailViewController alloc]init];
    roomDetailViewController.title = [self roomSubjectWithIndexPath:indexPath];
    roomDetailViewController.roomId = [self roomIdWithIndexPath:indexPath];
    
    [self.navigationController pushViewController:roomDetailViewController animated:YES];
    
}


@end
