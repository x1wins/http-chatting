//
//  LoginViewController.m
//  FlowerPaper
//
//  Created by Rhee Chang-Woo on 13. 1. 6..
//  Copyright (c) 2013년 Rhee Chang-Woo. All rights reserved.
//

#import "LoginViewController.h"
#import "common/CommonConst.h"
#import "common/CommonUtil.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"

#import "MyInfo.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize mainTableView = _mainTableView;
@synthesize idTextField = _idTextField;
@synthesize pwTextField = _pwTextField;
@synthesize loginSwitch = _loginSwitch;
@synthesize indicate = _indicate;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    _idTextField = [[UITextField alloc]initWithFrame:CGRectMake(160, 15, 150, 40)];
    _pwTextField = [[UITextField alloc]initWithFrame:CGRectMake(160, 15, 150, 40)];
    _idTextField.backgroundColor = [UIColor clearColor];
    _pwTextField.backgroundColor = [UIColor clearColor];
    _pwTextField.secureTextEntry = YES;
    _idTextField.placeholder = @"Required";
    _pwTextField.placeholder = @"Required";
    
    //스위치
    _loginSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(160, 10, 150, 40)];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *value = [defaults objectForKey:@"loginSwitch"];
    NSNumber *swstauts = [NSNumber numberWithInt:1];
    //스위치 상태 값 가져오기
    if (value == nil){
        [_loginSwitch setOn:NO];
    }else{
        if (value == swstauts) {
            [_loginSwitch setOn:YES];
            _idTextField.text = [defaults objectForKey:@"id"];
            _pwTextField.text = [defaults objectForKey:@"pw"];
        }else{
            [_loginSwitch setOn:NO];
        }
    }
    
    [_loginSwitch addTarget:self action:@selector(switchAction) forControlEvents:UIControlEventValueChanged];
    
    
    //커서
    [self focusUp];
}

-(void)switchAction {
    
    if (_loginSwitch.on) {
        NSLog(@"on");
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSNumber *swstauts = [NSNumber numberWithInt:1];
        [defaults setObject:swstauts forKey:@"loginSwitch"];
        [defaults setObject:_idTextField.text forKey:@"id"];
        [defaults setObject:_pwTextField.text forKey:@"pw"];
        [defaults synchronize];
    }else{
        NSLog(@"off");
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSNumber *swstauts = [NSNumber numberWithInt:0];
        [defaults setObject:swstauts forKey:@"loginSwitch"];
        [defaults setObject:nil forKey:@"id"];
        [defaults setObject:nil forKey:@"pw"];
        [defaults synchronize];
    }
}

- (void) showSignupModalView
{
    SignupViewController *signupViewController = [[SignupViewController alloc]init];
    [self presentViewController:signupViewController animated:YES completion:^{
        
    }];
}

#pragma mark - event

- (void) login {
    
    [self switchAction];
    //    NSLog(@"idTextField.text %d",[idTextField.text isEqualToString:@""]);
    
    //if([idTextField.text isEqualToString:@""]==YES){
    if([_idTextField.text length] == 0){
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:@"아이디를 입력하세요" delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
        alert.tag = 1;
        [alert show];
        return;
    }
    
    //if([pwTextField.text isEqualToString:@""]==YES){
    if([_pwTextField.text length] == 0){
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:@"비밀번호를 입력하세요" delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil, nil];
        alert.tag = 1;
        [alert show];
        return;
    }
    
    [self requestLogin];
    
}

- (void) focusUp {
    [_idTextField becomeFirstResponder];
}

#pragma mark - table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    int cell_count = 2;
    
    switch (section) {
        case 0:
            cell_count = 3;
            break;
        case 1:
        default:
            cell_count = 2;
            break;
    }
    
    return cell_count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.selectionStyle = NO;
    cell.accessoryType = UITableViewCellAccessoryNone;

    switch(indexPath.section)
    {
        case 0:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"아이디";
                    [cell addSubview:_idTextField];
                    break;
                case 1:
                    cell.textLabel.text = @"비밀번호";
                    [cell addSubview:_pwTextField];
                    break;
                case 2:
                    cell.textLabel.text = @"자동로그인";
                    [cell addSubview:_loginSwitch];
                    break;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"로그인";
                    cell.selectionStyle = YES;
                    break;
                case 1:
                    cell.textLabel.text = @"회원가입";
                    cell.selectionStyle = YES;
                    break;
            }
            break;
    }
    
    
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *) indexPath{
    
    int height = 50;
    return height;
}


//cell click event
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    switch(indexPath.section){
        case 1:
            switch (indexPath.row) {
                case 0:
                    [self login];
                    break;
                case 1:
//                    [self test];
                    [self showSignupModalView];
                    break;
            }
            break;
    }
    
    
}

- (NSString *)tableView:(UITableView *)tblView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName = nil;
    switch(section)
    {
        case 0:
            sectionName = @"접속을 환영합니다.";
            break;
        case 1:
            sectionName = @"";
            break;

    }
    return sectionName;
}

//http send
- (void)test
{
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"test", @"userid",
                            @"1",@"password",
                            @"http://localhost:8080/FlowerPaper/",@"currentUrl",
                            nil];
    NSString *strUrl = @"http://localhost:8080/FlowerPaper/user/list.json";
//    NSString *strUrl = @"http://localhost:8080/FlowerPaper/bbs/data/1/list/1.json";

    NSURL *url = [NSURL URLWithString:strUrl];
    AFHTTPClient *client = [[AFHTTPClient alloc]initWithBaseURL:url];
    
    //depending on what kind of response you expect.. change it if you expect XML
    [client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    [client getPath:strUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"success");
        NSLog(@"Request Successful, response '%@'", responseStr);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure");
        NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
    }];
    
    
    //    [self.view removeFromSuperview];
}

//http send
- (void) requestLogin
{
    
    NSString *userid = _idTextField.text;
    NSString *password = _pwTextField.text;
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                            userid, @"userid",
                            password, @"password",
                            nil];
    NSString *strUrl = [NSString stringWithFormat:SERVER_URL_HTTP,@"user/signin.json"];
    NSURL *url = [NSURL URLWithString:strUrl];
    AFHTTPClient *client = [[AFHTTPClient alloc]initWithBaseURL:url];
    
    //depending on what kind of response you expect.. change it if you expect XML
    [client registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    
    [client postPath:strUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSLog(@"success");
        NSLog(@"Request Successful, response '%@'", responseStr);
        
        
        NSDictionary *dic = [[CommonUtil share] buildDictionaryJsonWithJsonString:responseStr];
        NSString *sessionId = [[dic objectForKey:@"response"] objectForKey:@"result"];
        
        
        {
            // Dictionary of attributes for the new cookie
            NSDictionary *newCookieDict = [NSMutableDictionary
                                           dictionaryWithObjectsAndKeys:@"www.example.com", NSHTTPCookieDomain,
                                           @"JSESSIONID", NSHTTPCookieName,
                                           @"/", NSHTTPCookiePath,
                                           sessionId, NSHTTPCookieValue,
                                           @"0", NSHTTPCookieExpires
                                           , nil];
            
            
            NSHTTPCookie *newCookie = [NSHTTPCookie cookieWithProperties:newCookieDict];
            
            // Add the new cookie
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:newCookie];
            
            [self.view removeFromSuperview];
            
            [[MyInfo share] setUserid:1 username:@"changwoo"];
            
            [self.delegate loginSuccess:self];
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure");
        NSLog(@"[HTTPClient Error]: %@", error.localizedDescription);
    }];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
