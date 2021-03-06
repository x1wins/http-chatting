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

#import "MBProgressHUD.h"
#import "MyInfo.h"

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
    [_textView setScrollEnabled:NO];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

#pragma mark - request to server
- (void) sendMessage:(Message*)message
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    NSString *path = [NSString stringWithFormat:@"chat/message/save"];
    NSString *url = [NSString stringWithFormat:SERVER_URL_HTTP,path];
    NSURL *baseURL = [NSURL URLWithString:url];
    
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc]initWithBaseURL:baseURL];
    
    
    
    //http://localhost:8080/FlowerPaper/chat/message/save&content=hihi&userid=34&roomid=1
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSString stringWithFormat:@"%lld",message.roomid], @"roomid",
                            [NSString stringWithFormat:@"%@",message.user.userid], @"userid",
                            message.content, @"content", nil];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:url parameters:params];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSString *responseStr = [operation responseString];
        NSLog(@"%@",responseStr);
        [[CommonUtil share] buildErrorView:self jsonString:responseStr];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"error: %@", [operation error]);
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [[CommonUtil share] buildErrorView:self];
        [_textView resignFirstResponder];
        
    }];
    
    //call start on your request operation
    [operation start];
}


//long Polling
- (void) recevieDatas
{
    NSString *path = [NSString stringWithFormat:@"chat/recevice/%lld",_roomId];
    NSString *strUrl = [NSString stringWithFormat:SERVER_URL_HTTP,path];
    
    NSURL *url = [NSURL URLWithString:strUrl];
    AFHTTPClient *client = [[AFHTTPClient alloc]initWithBaseURL:url];
    
    //depending on what kind of response you expect.. change it if you expect XML
    [client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    [client getPath:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        //        NSLog(@"success");
        //        NSLog(@"Request Successful, response '%@'", responseStr);
        
        Message *message = [[CommonUtil share] messageWithResponseStr:responseStr];
        [_datas addObject:message];
        [_mainTableView reloadData];
        [self scrollsToBottomAnimated:YES];
        
        [self recevieDatas];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"failure");
        NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
        
        double delayInSeconds = 5.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self recevieDatas];
        });
    }];
}

- (void) reloadDatas
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *path = [NSString stringWithFormat:@"chat/message/find/%lld",_roomId];
    NSString *strUrl = [NSString stringWithFormat:SERVER_URL_HTTP,path];
    
    NSURL *url = [NSURL URLWithString:strUrl];
    AFHTTPClient *client = [[AFHTTPClient alloc]initWithBaseURL:url];
    
    //depending on what kind of response you expect.. change it if you expect XML
    [client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    [client getPath:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
//        NSLog(@"success");
//        NSLog(@"Request Successful, response '%@'", responseStr);
        
        _datas = [NSMutableArray arrayWithArray:[[CommonUtil share] messagesWithResponseStr:responseStr]];
        [_mainTableView reloadData];
        [self scrollsToBottomAnimated:YES];
        
        [self recevieDatas];
        
        [hud hide:YES];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"failure");
        NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);

        [hud hide:YES];
        [[CommonUtil share] buildErrorView:self];
        
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

    Message *message = [_datas objectAtIndex:indexPath.row];
    
    if (cell == nil)
    {
        cell = [[RoomDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];

        NSArray *array = [[NSBundle mainBundle]loadNibNamed:@"RoomDetailCell" owner:nil options:nil];
        
        if([self isMyMessage:message])
        {
            cell = [array objectAtIndex:1];
        }
        else
        {
            cell = [array objectAtIndex:0];
        }
    }
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [cell setFrameWithMessage:message];

    // Configure the cell...
    cell.selectionStyle = NO;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *) indexPath{
    
    Message *message = [_datas objectAtIndex:indexPath.row];
    int height = message.cellHeight;
    return height;
}

- (BOOL) isMyMessage:(Message*)message
{
    NSString *myUserid = [[MyInfo share] userid];
    NSString *userid = [NSString stringWithFormat:@"%@",message.user.userid];
    
    return [userid isEqualToString:myUserid];
}


#pragma mark - my action
- (void)scrollsToBottomAnimated:(BOOL)animated
{
    if([_datas count] > 0)
    {
        [_mainTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(_datas.count - 1) inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:animated];
    }
}

#pragma mark UITextView Delegate
- (void)textViewDidChange:(UITextView *)textView
{
    if([textView.text isEqualToString:@""])
    {
        _keypad.frame = _initKeypadRect;
        return;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [self sendTextMessage];
        return NO;
    }
    return YES;
}

#pragma mark event
- (void) sendTextMessage
{
    NSString* content = _textView.text;
    if(content == nil) return;
    if([content length] == 0) return;
    _textView.text = @"";
    
    NSString *userid = [[MyInfo share]userid];
    NSString *username = [[MyInfo share]username];
    User *user = [User setUserid:userid username:username userPhotoUrl:nil];
    Message *message = [Message setRoomid:_roomId messageid:nil user:user imgUrl:nil content:content date:nil];
    //post
    [self sendMessage:message];
}


#pragma mark -- keyboard
-(void)keyboardWillShow:(NSNotification *)aNotification
{
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES notification:aNotification];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO notification:aNotification];
    }
}

-(void)keyboardWillHide:(NSNotification *)aNotification
{
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES notification:aNotification];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO notification:aNotification];
    }
}

- (void)clickedTableView:(UITapGestureRecognizer*)gesture
{
    [_textView resignFirstResponder];
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp notification:(NSNotification*)aNotification
{
    if(movedUp)
    {
        UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickedTableView:)] ;
        [_mainTableView addGestureRecognizer:tapGesture];
    }
    else
    {
        for(UITapGestureRecognizer *gesture in [_mainTableView gestureRecognizers])
        {
            if([gesture isKindOfClass:[UITapGestureRecognizer class]]){
                if (gesture.numberOfTapsRequired == 1)
                {
                    [_mainTableView removeGestureRecognizer:gesture];
                }
            }
        }
    }
    
    // Get animation info from userInfo
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    NSDictionary* userInfo = [aNotification userInfo];
    CGRect keyboardEndFrame;
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration]; // if you want to slide up the view
    
    _keyboardHeight = keyboardEndFrame.size.height;
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= _keyboardHeight;
        _initKeypadRect = _keypad.frame;
        //        rect.size.height += keyboardHeight;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += _keyboardHeight;
        //        rect.size.height -= keyboardHeight;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


@end